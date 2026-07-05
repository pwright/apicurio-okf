#!/usr/bin/env python3
"""Wrap Blockscape .bs files as generated Markdown pages."""

from __future__ import annotations

import argparse
import json
from pathlib import Path


DEFAULT_ARRAY_TITLES = {
    "apicurio": "Apicurio Blockscape maps",
}

DEFAULT_SOURCE_BASE_URL = "https://raw.githubusercontent.com/pwright/apicurio-okf/refs/heads/main/"
DEFAULT_BLOCKSCAPE_BASE_URL = "https://pwright.github.io/blockscape/"


def page_title(path: Path, data: object) -> str:
    if isinstance(data, dict) and isinstance(data.get("title"), str):
        return data["title"]

    return DEFAULT_ARRAY_TITLES.get(
        path.stem,
        path.stem.replace("-", " ").replace("_", " ").title(),
    )


def source_url(base_url: str, source: Path) -> str:
    return base_url.rstrip("/") + "/" + source.as_posix()


def edit_url(blockscape_base_url: str, raw_source_url: str) -> str:
    return blockscape_base_url.rstrip("/") + "/?load=" + raw_source_url


def render_page(source: Path, source_base_url: str, blockscape_base_url: str) -> str:
    raw = source.read_text(encoding="utf-8").rstrip()
    data = json.loads(raw)
    title = page_title(source, data)
    raw_url = source_url(source_base_url, source)
    blockscape_url = edit_url(blockscape_base_url, raw_url)

    return "\n".join(
        [
            "---",
            f'title: "{title}"',
            "type: BlockscapeMap",
            "status: generated",
            f"source_path: {source.as_posix()}",
            "tags:",
            "  - apicurio",
            "  - blockscape",
            "---",
            "",
            f"# {title}",
            "",
            f"Edit: [Blockscape]({blockscape_url})",
            "",
            "```bs full",
            raw,
            "```",
            "",
        ]
    )


def update_maps(
    input_root: Path,
    output_root: Path,
    source_base_url: str,
    blockscape_base_url: str,
) -> None:
    output_root.mkdir(parents=True, exist_ok=True)

    for source in sorted(input_root.glob("*.bs")):
        output = output_root / f"{source.stem}.md"
        output.write_text(
            render_page(source, source_base_url, blockscape_base_url),
            encoding="utf-8",
        )
        print(output.as_posix())


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, default=Path("maps"))
    parser.add_argument("--output", type=Path, default=Path("generated/maps"))
    parser.add_argument("--source-base-url", default=DEFAULT_SOURCE_BASE_URL)
    parser.add_argument("--blockscape-base-url", default=DEFAULT_BLOCKSCAPE_BASE_URL)
    args = parser.parse_args()

    update_maps(
        args.input,
        args.output,
        args.source_base_url,
        args.blockscape_base_url,
    )


if __name__ == "__main__":
    main()
