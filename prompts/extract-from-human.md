# Prompt: extract OKF from human source docs

Use `human/<repo-name>/` as read-only source material. Create small OKF-style Markdown pages under `generated/`.

Rules:

- Preserve source provenance in YAML front matter.
- Prefer one concept, command, resource, or workflow per file.
- Do not rewrite the original documentation as marketing copy.
- Do not invent source paths.
- Always include the repo-name segment in source paths, for example `human/apicurio-registry/README.md`.
- Mark all outputs as `status: generated` and `reviewed: false`.

Suggested front matter:

```yaml
type: Concept
title: <title>
id: apicurio-concept-<slug>
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: <commit from sources/apicurio-registry.md>
source_paths:
  - human/apicurio-registry/<path>
tags: []
related: []
```

Output directories:

```text
generated/concepts/
generated/resources/
generated/workflows/
generated/architecture/
```
