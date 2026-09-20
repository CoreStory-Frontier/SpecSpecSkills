from __future__ import annotations

import importlib.util
import sys
import tempfile
import textwrap
import unittest
from pathlib import Path


SCRIPT = (
    Path(__file__).parents[1]
    / "plugins"
    / "specspec-skills"
    / "scripts"
    / "validate_specspec_design.py"
)
SPEC = importlib.util.spec_from_file_location("validate_specspec_design", SCRIPT)
assert SPEC and SPEC.loader
validator = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = validator
SPEC.loader.exec_module(validator)


def document(frontmatter: str, body: str) -> str:
    clean_frontmatter = textwrap.dedent(frontmatter).strip()
    clean_body = textwrap.dedent(body).strip()
    return f"---\n{clean_frontmatter}\n---\n\n{clean_body}\n"


class DesignValidatorTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp_dir = tempfile.TemporaryDirectory()
        self.root = Path(self.temp_dir.name)
        self.write(
            "index.md",
            document('specspec_version: "0.1"\nkind: design-spec', "# Design"),
        )

    def tearDown(self) -> None:
        self.temp_dir.cleanup()

    def write(self, relative: str, content: str) -> None:
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")

    def add_valid_graph(self) -> None:
        self.write(
            "system/technical-overview.md",
            document(
                """
                type: Technical Overview
                spec_id: TECH-overview
                layer: L3
                provenance: supplied
                """,
                """
                # Decomposition
                * [API](../components/api.md)
                """,
            ),
        )
        self.write(
            "components/api.md",
            document(
                """
                type: Component
                spec_id: CMP-api
                layer: L2
                provenance: supplied
                """,
                """
                # Decomposition
                * [HTTP module](../modules/http.md)

                # Related
                * [Technical overview](../system/technical-overview.md)
                """,
            ),
        )
        self.write(
            "modules/http.md",
            document(
                """
                type: Module
                spec_id: MOD-http
                layer: L1
                provenance: supplied
                """,
                """
                # Related
                * [API](../components/api.md)
                """,
            ),
        )

    def messages(self) -> list[str]:
        return [finding.message for finding in validator.validate_bundle(self.root)]

    def test_valid_l3_to_l1_graph_passes(self) -> None:
        self.add_valid_graph()
        self.assertEqual([], validator.validate_bundle(self.root))

    def test_root_index_is_not_required(self) -> None:
        self.add_valid_graph()
        (self.root / "index.md").unlink()
        self.assertEqual([], validator.validate_bundle(self.root))

    def test_layers_outside_design_scope_are_ignored(self) -> None:
        self.add_valid_graph()
        self.write(
            "product/capabilities/example.md",
            document(
                """
                type: Capability
                spec_id: CAP-example
                layer: L4
                provenance: supplied
                """,
                "# Purpose\nExample capability.",
            ),
        )
        self.write(
            "files/example.py.md",
            document(
                """
                type: Source File
                spec_id: FILE-example-py
                layer: L0
                provenance: observed
                """,
                "# Purpose\nExample source file.",
            ),
        )
        self.assertEqual([], validator.validate_bundle(self.root))

    def test_empty_bundle_is_rejected(self) -> None:
        self.assertTrue(
            any("no L1-L3 design concepts" in message for message in self.messages())
        )

    def test_wrong_type_layer_is_rejected(self) -> None:
        self.add_valid_graph()
        path = self.root / "components" / "api.md"
        path.write_text(path.read_text().replace("layer: L2", "layer: L3"))
        self.assertTrue(any("belongs to L2" in message for message in self.messages()))

    def test_skipped_layer_decomposition_is_rejected(self) -> None:
        self.add_valid_graph()
        path = self.root / "system" / "technical-overview.md"
        path.write_text(
            path.read_text().replace("../components/api.md", "../modules/http.md")
        )
        self.assertTrue(
            any("must decompose directly to L2" in message for message in self.messages())
        )

    def test_missing_backlink_is_rejected(self) -> None:
        self.add_valid_graph()
        path = self.root / "modules" / "http.md"
        path.write_text(path.read_text().replace("* [API](../components/api.md)", ""))
        self.assertTrue(any("missing `# Related` backlink" in m for m in self.messages()))

    def test_duplicate_spec_id_is_rejected(self) -> None:
        self.add_valid_graph()
        self.write(
            "modules/duplicate.md",
            document(
                """
                type: Module
                spec_id: MOD-http
                layer: L1
                provenance: supplied
                """,
                "# Related\n* [API](../components/api.md)",
            ),
        )
        self.assertTrue(any("duplicate spec_id" in message for message in self.messages()))

    def test_orphan_module_is_rejected(self) -> None:
        self.add_valid_graph()
        self.write(
            "modules/orphan.md",
            document(
                """
                type: Module
                spec_id: MOD-orphan
                layer: L1
                provenance: supplied
                """,
                "# Related\n",
            ),
        )
        self.assertTrue(any("L1 module is not used" in message for message in self.messages()))


if __name__ == "__main__":
    unittest.main()
