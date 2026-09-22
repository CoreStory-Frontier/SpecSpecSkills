"""Emit L0 and implementation-copy documents as JSON for apply_patch; verify existing evidence.

This development tool is outside the application source root. It never edits files.
Run from any directory with Python 3.13. Apply the emitted document map through apply_patch.
Use --check to check the evidence against source bytes and reciprocal relationships.
"""

import ast
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
APP = ROOT / 'app'
DEST = ROOT / 'implemented-spec'
EXCLUDED = {'.venv', '__pycache__', '.pytest_cache', 'instance', 'test-results'}
OWNERS = {
    'equipment_catalog': 'equipment-catalog', 'schedule_management': 'schedule-management',
    'scheduling_operations': 'scheduling-operations', 'equipment_use_management': 'equipment-use-management',
    'actor_access': 'actor-access', 'web_interaction': 'web-interaction',
}
FLOWS = {
    'equipment_catalog': 'transaction opens a SQLite connection, enables foreign keys, and starts BEGIN IMMEDIATE. It yields to the caller, commits on success, rolls back on any exception, and always closes. add checks the name before insert. get rejects a missing row. all_equipment orders rows by identity.',
    'schedule_management': 'period normalizes both bounds before comparison. Availability loops through assets and checks maintenance before confirmed reservations. reserve checks the asset and conflicts before insert. maintenance inserts a period, collects affected confirmed reservations, updates their states, and logs each identity. cancel requires invalid state and overlapping maintenance. complete_return updates confirmed state only.',
    'scheduling_operations': 'initialize creates catalog then schedule storage. execute selects one operation and delegates to catalog or schedule. The mine branch passes the authorized actor as the employee filter. Unknown operations fail. Handoff and history helpers compose authoritative catalog and schedule context; completion and timestamp helpers delegate to Schedule Management.',
    'equipment_use_management': 'pickup obtains scheduling context, normalizes the time, checks confirmed state and absence of a use record, then inserts. record_return checks pickup, absence of return, and time order before updating use and requesting scheduling completion in the same transaction. history combines scheduling context with use rows for one item. execute dispatches three operations and rejects other names.',
    'actor_access': 'authorize resolves the selected demo identity to its fixed role set, looks up the operation permission, and rejects missing identities, unknown operations, or insufficient roles. It returns the authorized identity. Web Interaction passes this identity to scheduling; mine uses it as the owner filter and reserve uses it as the reservation employee. Client-supplied owner fields cannot change that scope.',
    'web_interaction': 'create_app reads environment and test overrides, creates the database directory, and initializes both domain stores in one transaction. GET / creates a session CSRF token and renders no protected records. POST checks CSRF and Actor Access before the serialized transaction. It dispatches scheduling or handoff, then returns JSON or HTML. PermissionError becomes 403; ValueError becomes 400. Transaction errors roll back before the response.',
}


def inventory():
    """Return authored application files; generated lockfile is hashed separately."""
    return sorted(p for p in APP.rglob('*') if p.is_file()
                  and not EXCLUDED.intersection(p.relative_to(APP).parts)
                  and not p.name.startswith('equipment.sqlite') and p.suffix not in ('.sqlite', '.pyc')
                  and p.name != 'uv.lock')


def blob(path):
    """Calculate Git's content identifier without altering Git or claiming a commit."""
    return subprocess.check_output(['git', 'hash-object', str(path)], text=True).strip()


def owner(path):
    """Map source and supporting artifacts to their existing Module responsibility."""
    return OWNERS.get(path.stem, 'web-interaction')


def relative(source, target):
    """Create a portable Markdown link relative to its containing document."""
    return os.path.relpath(target, source.parent).replace(os.sep, '/')


def symbols(tree):
    """Enumerate all functions, nested handlers, and file-level named bindings."""
    result = []
    for node in ast.walk(tree):
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
            result.append(node)
    for node in tree.body:
        if isinstance(node, (ast.Assign, ast.AnnAssign)):
            result.append(node)
    return sorted(result, key=lambda node: node.lineno)


def documents():
    """Construct source-derived L0 documents and an extended copy of the approved design."""
    sources = inventory()
    modules = {'.'.join(p.relative_to(APP).with_suffix('').parts): p for p in sources if p.suffix == '.py'}
    trees = {p: ast.parse(p.read_text()) for p in sources if p.suffix == '.py'}
    internal = {p: set() for p in sources}
    external = {p: set() for p in sources}
    for path, tree in trees.items():
        package = '.'.join(path.relative_to(APP).parent.parts)
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                candidates = [a.name for a in node.names]
            elif isinstance(node, ast.ImportFrom):
                base = importlib.util.resolve_name('.' * node.level + (node.module or ''), package) if node.level else (node.module or '')
                candidates = [base] + [base + '.' + a.name for a in node.names]
            else:
                continue
            found = {modules[name] for name in candidates if name in modules}
            if found:
                internal[path].update(found)
            else:
                external[path].add(candidates[0])
    template = APP / 'equipment_reservation/web_access/templates/index.html'
    web = APP / 'equipment_reservation/web_access/web_interaction.py'
    internal[web].add(template)
    result = {}
    docs = {p: DEST / 'files' / (p.relative_to(APP).as_posix() + '.md') for p in sources}
    for path in sources:
        source_path = path.relative_to(APP).as_posix()
        text = path.read_text()
        tree = trees.get(path)
        purpose = ast.get_docstring(tree) if tree else {
            'index.html': 'Render the localhost demo workspace, labelled UTC forms, result data, and error messages.',
            'pyproject.toml': 'Declare Python and dependency constraints, uv mode, and pytest discovery.',
            '.gitignore': 'Exclude local environments, caches, database contents, and test artifacts from Git.',
            'README.md': 'Explain setup, startup, verification, state rules, ownership, and reference limits.',
        }[path.name]
        role = 'test' if 'tests' in path.parts else 'doc' if path.suffix == '.md' else 'config' if path.name in ('.gitignore','pyproject.toml') else 'source'
        language = {'.py':'python','.html':'html','.toml':'toml','.md':'markdown'}.get(path.suffix, 'gitignore')
        fields = {'type':'Source File','title':source_path,'description':purpose.split('\n')[0],
                  'spec_id':'FILE-' + re.sub('[^a-zA-Z0-9]+','-',source_path).strip('-'),
                  'layer':'L0','provenance':'observed','generator':'agent','source_path':source_path,
                  'git_blob':blob(path),'language':language,'role':role,'revision_status':'uncommitted'}
        body = '---\n' + ''.join(f'{k}: {json.dumps(v)}\n' for k,v in fields.items()) + '---\n\n'
        body += '# Purpose\n\n' + purpose + '\n\n# Responsibilities\n\n'
        if tree:
            for node in tree.body:
                if isinstance(node, (ast.FunctionDef, ast.ClassDef)):
                    body += '- ' + (ast.get_docstring(node) or node.name) + '\n'
        else:
            body += '- ' + purpose + '\n'
        body += '\n# Symbols\n\n'
        anchors = []
        if tree:
            for node in symbols(tree):
                anchor = f'{source_path}:{node.lineno}-{node.end_lineno}'
                anchors.append(anchor)
                if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    signature = node.name + '(' + ast.unparse(node.args) + ')'
                    description = ast.get_docstring(node) or 'See the behavior at the source anchor.'
                    body += f'## `{signature}`\n\n{description}\n\n'
                    calls = sorted({ast.unparse(n.func) for n in ast.walk(node) if isinstance(n, ast.Call)})
                    body += 'Calls: ' + ', '.join(f'`{c}`' for c in calls) + '.\n\n' if calls else ''
                    conditions = sorted({ast.unparse(n.test) for n in ast.walk(node) if isinstance(n, ast.If)})
                    if conditions:
                        body += 'Branch conditions: ' + '; '.join(f'`{c}`' for c in conditions) + '.\n\n'
                else:
                    body += '## File binding\n\n`' + ast.unparse(node).replace('\n',' ') + '`\n\n'
                body += 'Evidence: `' + anchor + '`.\n\n'
        else:
            body += 'No code declarations. Document and configuration units are listed below.\n\n'
            for i, line in enumerate(text.splitlines(),1):
                if line.strip() and (path.name == '.gitignore' or path.suffix == '.toml' or line.startswith('#') or (path.suffix == '.html' and ('name=' in line or 'formaction=' in line or '<style>' in line or '<form' in line or '{%' in line))):
                    anchors.append(f'{source_path}:{i}')
                    body += f'- `{source_path}:{i}` — `' + line.strip().replace('`','') + '`\n'
            if not anchors:
                anchors.append(f'{source_path}:1')
        if tree or path.suffix == '.html':
            body += '\n# Control flow\n\n'
            body += ('The listed operations run in caller order. Conditions above select validation and failure paths. '
                     'Tests assert results; failures stop the test.\n' if role == 'test' else
                     FLOWS[path.stem] + '\n' if tree else
                     'The browser submits the selected form action. Jinja renders errors or JSON results with escaping.\n')
        body += '\n# Data & side effects\n\n'
        body += ('Uses isolated SQLite files and HTTP/browser sessions; browser tests bind a temporary localhost server.\n' if role == 'test' else
                 'Owns the SQLite connection lifecycle and equipment table. Creates the schema, inserts equipment, and reads records. No event logging occurs in this file.\n' if path.stem == 'equipment_catalog' else
                 'SQLite operations use the caller transaction; changes commit together or roll back on error. Candidate outcome events use Python logging before the caller commits. Logs are not a durable transaction ledger.\n' if path.stem in ('schedule_management','equipment_use_management') else
                 'Starts Flask storage and request handling; reads environment configuration, uses signed sessions, and renders the template.\n' if path.stem == 'web_interaction' else
                 'Dispatches calls to owned scheduling operations in the caller transaction.\n' if path.stem == 'scheduling_operations' else
                 'No direct persistent writes. Policy data and presentation/configuration support the owning Module.\n')
        body += '\n# Dependencies\n\n'
        for dep in sorted(internal[path]):
            body += f'- Uses [{dep.relative_to(APP)}]({relative(docs[path],docs[dep])}).\n'
        if external[path]:
            body += '- External/standard-library imports: ' + ', '.join(sorted(external[path])) + '.\n'
        reverse = [p for p in sources if path in internal[p]]
        for dep in reverse:
            body += f'- Used by [{dep.relative_to(APP)}]({relative(docs[path],docs[dep])}).\n'
        if not internal[path] and not external[path] and not reverse:
            body += 'No code imports. This is a supporting document or configuration artifact.\n'
        body += '\n# Errors\n\n'
        body += ('Assertion failures report unmet test expectations; setup and browser failures fail the run.\n' if role == 'test' else
                 'PermissionError denies missing or unauthorized identities.\n' if path.stem == 'actor_access' else
                 'PermissionError produces HTTP 403. ValueError produces HTTP 400. Unexpected errors are not presented as success.\n' if path.stem == 'web_interaction' else
                 'Validation raises ValueError as described by each operation. SQLite and other unexpected failures propagate; transaction owners roll back.\n' if tree else
                 'No application exceptions are raised by this artifact.\n')
        body += '\n# Configuration\n\n'
        body += ('EQUIPMENT_DATABASE selects the database file. EQUIPMENT_SECRET optionally fixes the session secret. '
                 'Tests override configuration with isolated paths and test-only secrets. No secret values are documented.\n' if path.stem == 'web_interaction' else
                 'requires-python restricts the interpreter to Python 3.13. dependencies installs Flask 3.1. The dev group supplies pytest and Playwright. tool.pytest.ini_options adds the project to import lookup and discovers tests/. tool.uv disables package installation; run from this directory. uv.lock pins the resolved versions.\n' if path.name == 'pyproject.toml' else
                 'See the named declarations or artifact units above. No secret configuration values are recorded.\n')
        if role == 'source':
            body += '\n# Tests\n\n'
            for test in [p for p in sources if p.name.startswith('test_')]:
                body += f'- [{test.name}]({relative(docs[path],docs[test])}) — application integration and browser coverage.\n'
        body += f'\n# Related\n\n- [{owner(path)}]({relative(docs[path],DEST / "modules" / (owner(path)+".md"))})\n'
        body += '\n# Evidence\n\n' + ''.join(f'- `{a}`\n' for a in anchors)
        body += '\n# Notes\n\nWorking-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.\n'
        result[str(docs[path])] = body
    for source in (ROOT / 'spec').rglob('*.md'):
        dest = DEST / source.relative_to(ROOT / 'spec')
        content = source.read_text()
        if source.parent.name == 'modules' and source.name != 'index.md':
            owned = [p for p in sources if owner(p) == source.stem]
            links = '\n'.join(f'- [{p.relative_to(APP)}]({relative(dest,docs[p])})' for p in owned)
            for placeholder in ('_L0 source-file documentation is outside this design scope._', '_L1 is the terminal layer of this design bundle._', '_L0 evidence is outside this design scope._'):
                content = content.replace(placeholder, links)
            if source.stem == 'actor-access':
                content = content.replace('# Dependencies', 'Observed reference implementation: `authorize` returns the permitted actor identity. Web Interaction passes it to Scheduling Operations. The own-reservation query filters by that identity; reservation creation uses it as the employee. Request fields cannot override ownership. The approved fixed demo adapter replaces the external provider for this trial only.\n\n# Dependencies')
        result[str(dest)] = content
    result[str(DEST/'files/index.md')] = '# Source files (L0)\n\n' + ''.join(f'* [{p.relative_to(APP)}]({relative(DEST/"files/index.md", docs[p])}) - {owner(p)}.\n' for p in sources)
    result[str(DEST/'index.md')] = '# Implementation evidence\n\nWorking-tree evidence from `../app/`; no Git revision is claimed.\n\n' + ''.join(f'* [{name}]({folder}/index.md) - {name}.\n' for name,folder in [('Product','product'),('System','system'),('Components','components'),('Modules','modules'),('Source files','files')])
    return result


def check():
    """Verify exact regenerated content, source coverage, hashes, and all relative links."""
    expected = documents()
    for name, content in expected.items():
        path = Path(name)
        assert path.exists() and path.read_text() == content, f'Stale evidence: {path}'
        for target in re.findall(r'\[[^\]]+\]\(([^)]+)\)', content):
            if not target.startswith(('http:', 'https:')):
                assert (path.parent / target.split('#')[0]).exists(), f'Broken link: {path} -> {target}'
    actual = set(DEST.rglob('*.md'))
    assert actual == {Path(p) for p in expected}, 'Unexpected or missing implementation document'
    print(f'PASS: {len(inventory())} L0 files, {len(expected)} total documents; hashes, anchors and links match generated source evidence.')


if __name__ == '__main__':
    if '--check' in sys.argv:
        check()
    else:
        print(json.dumps(documents()))
