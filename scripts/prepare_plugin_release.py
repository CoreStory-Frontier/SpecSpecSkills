#!/usr/bin/env python3
"""Validate and package all marketplace plugins for a tagged release."""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
import zipfile
from pathlib import Path
from typing import Any


class ReleaseError(ValueError):
    """A release input or repository invariant is invalid."""


def read_json(path: Path) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError as error:
        raise ReleaseError(f"required file does not exist: {path}") from error
    except json.JSONDecodeError as error:
        raise ReleaseError(f"invalid JSON in {path}: {error}") from error

    if not isinstance(value, dict):
        raise ReleaseError(f"expected a JSON object in {path}")
    return value


def release_version(tag: str) -> str:
    if not tag.startswith("v") or len(tag) == 1:
        raise ReleaseError("the release tag must start with `v` and contain a version")
    version = tag[1:]
    if "/" in version or "\\" in version or any(character.isspace() for character in version):
        raise ReleaseError("the release version cannot contain slashes or whitespace")
    return version


def require_value(document: dict[str, Any], key: str, expected: str, path: Path) -> None:
    actual = document.get(key)
    if actual != expected:
        raise ReleaseError(
            f"{path}: expected {key}={expected!r}, found {actual!r}"
        )


def plugin_directories(root: Path) -> list[Path]:
    plugins_root = root / "plugins"
    if not plugins_root.is_dir():
        raise ReleaseError(f"plugin directory does not exist: {plugins_root}")

    plugins = sorted(
        path for path in plugins_root.iterdir() if path.is_dir() and (path / "plugin.json").is_file()
    )
    if not plugins:
        raise ReleaseError(f"no plugins found in {plugins_root}")
    return plugins


def validate_manifests(root: Path, plugins: list[Path], version: str) -> None:
    plugin_names = {plugin.name for plugin in plugins}

    for plugin in plugins:
        for relative in (
            Path("plugin.json"),
            Path(".claude-plugin/plugin.json"),
            Path(".codex-plugin/plugin.json"),
        ):
            path = plugin / relative
            manifest = read_json(path)
            require_value(manifest, "name", plugin.name, path)
            require_value(manifest, "version", version, path)

    marketplace_path = root / ".claude-plugin" / "marketplace.json"
    marketplace = read_json(marketplace_path)
    require_value(marketplace, "version", version, marketplace_path)

    entries = marketplace.get("plugins")
    if not isinstance(entries, list):
        raise ReleaseError(f"{marketplace_path}: `plugins` must be an array")

    marketplace_names: set[str] = set()
    for index, entry in enumerate(entries):
        if not isinstance(entry, dict):
            raise ReleaseError(f"{marketplace_path}: plugins[{index}] must be an object")
        name = entry.get("name")
        if not isinstance(name, str):
            raise ReleaseError(f"{marketplace_path}: plugins[{index}].name must be a string")
        if name in marketplace_names:
            raise ReleaseError(f"{marketplace_path}: duplicate plugin entry {name!r}")
        marketplace_names.add(name)
        require_value(entry, "version", version, marketplace_path)
        require_value(entry, "source", f"./plugins/{name}", marketplace_path)

    if marketplace_names != plugin_names:
        missing = sorted(plugin_names - marketplace_names)
        extra = sorted(marketplace_names - plugin_names)
        raise ReleaseError(
            f"{marketplace_path}: plugin set does not match plugins/: "
            f"missing={missing}, extra={extra}"
        )


def should_package(path: Path) -> bool:
    return (
        "__pycache__" not in path.parts
        and path.name != ".DS_Store"
        and path.suffix not in {".pyc", ".pyo"}
    )


def write_plugin_archive(plugin: Path, output: Path, version: str) -> Path:
    archive = output / f"{plugin.name}-{version}.zip"
    with zipfile.ZipFile(
        archive,
        mode="x",
        compression=zipfile.ZIP_DEFLATED,
        compresslevel=9,
    ) as package:
        for path in sorted(item for item in plugin.rglob("*") if item.is_file()):
            relative = path.relative_to(plugin)
            if not should_package(relative):
                continue
            if path.is_symlink():
                raise ReleaseError(f"plugin package cannot contain a symbolic link: {path}")

            info = zipfile.ZipInfo(f"{plugin.name}/{relative.as_posix()}")
            info.date_time = (1980, 1, 1, 0, 0, 0)
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = (path.stat().st_mode & 0xFFFF) << 16
            package.writestr(info, path.read_bytes(), compresslevel=9)
    return archive


def write_checksums(archives: list[Path], output: Path) -> Path:
    checksum_path = output / "SHA256SUMS"
    lines = []
    for archive in archives:
        digest = hashlib.sha256(archive.read_bytes()).hexdigest()
        lines.append(f"{digest}  {archive.name}\n")
    checksum_path.write_text("".join(lines), encoding="utf-8")
    return checksum_path


def prepare_release(root: Path, tag: str, output: Path) -> list[Path]:
    version = release_version(tag)
    plugins = plugin_directories(root)
    validate_manifests(root, plugins, version)

    output.mkdir(parents=True, exist_ok=True)
    if any(output.iterdir()):
        raise ReleaseError(f"output directory is not empty: {output}")

    archives = [write_plugin_archive(plugin, output, version) for plugin in plugins]
    checksum = write_checksums(archives, output)
    return [*archives, checksum]


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tag", required=True, help="release tag, such as v1.1.0")
    parser.add_argument(
        "--root",
        type=Path,
        default=Path(__file__).resolve().parents[1],
        help="repository root",
    )
    parser.add_argument("--output", type=Path, default=Path("dist"))
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    try:
        artifacts = prepare_release(args.root.resolve(), args.tag, args.output.resolve())
    except ReleaseError as error:
        print(f"error: {error}", file=sys.stderr)
        return 1

    for artifact in artifacts:
        print(artifact)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
