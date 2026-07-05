# Agent rules

- Treat each `human/<repo-name>/` directory as a read-only upstream snapshot.
- Write draft OKF files to `generated/`.
- Do not write to `reviewed/` unless explicitly asked to promote reviewed content.
- Preserve source provenance in YAML front matter.
- Prefer small, traceable pages over large rewrites.
- Log non-critical progress to stderr.
