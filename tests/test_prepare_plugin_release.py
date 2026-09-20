from __future__ import annotations

import hashlib
import importlib.util
import json
import sys
import tempfile
import unittest
import zipfile
from pathlib import Path


SCRIPT = Path(__file__).parents[1] / "scripts" / "prepare_plugin_release.py"
SPEC = importlib.util.spec_from_file_location("prepare_plugin_release", SCRIPT)
assert SPEC and SPEC.loader
release = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = release
SPEC.loader.exec_module(release)


class PreparePluginReleaseTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp_dir = tempfile.TemporaryDirectory()
        self.root = Path(self.temp_dir.name)
        self.plugin = self.root / "plugins" / "sample-plugin"
        self.write_json(
            ".claude-plugin/marketplace.json",
            {
                "name": "sample-marketplace",
                "version": "1.2.3",
                "plugins": [
                    {
                        "name": "sample-plugin",
                        "version": "1.2.3",
                        "source": "./plugins/sample-plugin",
                    }
                ],
            },
        )
        manifest = {"name": "sample-plugin", "version": "1.2.3"}
        self.write_json("plugins/sample-plugin/plugin.json", manifest)
        self.write_json("plugins/sample-plugin/.claude-plugin/plugin.json", manifest)
        self.write_json("plugins/sample-plugin/.codex-plugin/plugin.json", manifest)
        self.write("plugins/sample-plugin/skills/example/SKILL.md", "# Example\n")

    def tearDown(self) -> None:
        self.temp_dir.cleanup()

    def write(self, relative: str, content: str) -> None:
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")

    def write_json(self, relative: str, value: object) -> None:
        self.write(relative, json.dumps(value))

    def test_packages_plugin_and_hidden_manifests(self) -> None:
        output = self.root / "dist"
        artifacts = release.prepare_release(self.root, "v1.2.3", output)

        archive = output / "sample-plugin-1.2.3.zip"
        self.assertEqual(artifacts, [archive, output / "SHA256SUMS"])
        with zipfile.ZipFile(archive) as package:
            self.assertEqual(
                set(package.namelist()),
                {
                    "sample-plugin/plugin.json",
                    "sample-plugin/.claude-plugin/plugin.json",
                    "sample-plugin/.codex-plugin/plugin.json",
                    "sample-plugin/skills/example/SKILL.md",
                },
            )

        digest = hashlib.sha256(archive.read_bytes()).hexdigest()
        self.assertEqual(
            (output / "SHA256SUMS").read_text(encoding="utf-8"),
            f"{digest}  sample-plugin-1.2.3.zip\n",
        )

    def test_rejects_manifest_version_that_does_not_match_tag(self) -> None:
        manifest_path = self.plugin / "plugin.json"
        self.write_json(
            str(manifest_path.relative_to(self.root)),
            {"name": "sample-plugin", "version": "1.2.2"},
        )

        with self.assertRaisesRegex(release.ReleaseError, "expected version='1.2.3'"):
            release.prepare_release(self.root, "v1.2.3", self.root / "dist")

    def test_rejects_marketplace_plugin_set_mismatch(self) -> None:
        self.write_json(
            ".claude-plugin/marketplace.json",
            {"name": "sample-marketplace", "version": "1.2.3", "plugins": []},
        )

        with self.assertRaisesRegex(release.ReleaseError, "plugin set does not match"):
            release.prepare_release(self.root, "v1.2.3", self.root / "dist")

    def test_rejects_tag_without_version(self) -> None:
        with self.assertRaisesRegex(release.ReleaseError, "contain a version"):
            release.prepare_release(self.root, "v", self.root / "dist")

    def test_rejects_unsafe_version_path(self) -> None:
        with self.assertRaisesRegex(release.ReleaseError, "slashes or whitespace"):
            release.prepare_release(self.root, "vrelease/1.2.3", self.root / "dist")


if __name__ == "__main__":
    unittest.main()
