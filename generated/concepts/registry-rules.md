---
type: Concept
title: Registry rules
id: apicurio-concept-registry-rules
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-intro-to-registry-rules.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-registry-concepts-glossary.adoc
tags:
  - apicurio
  - concept
  - governance
related:
  - apicurio-concept-data-contracts
  - apicurio-concept-registry-artifact-model
  - apicurio-workflow-deprecate-schema-version
decision:
  registry_goal:
    - compatibility-governance
    - event-schema-governance
    - api-contract-governance
  change_policy:
    - validity-only
    - backward-compatible
    - backward-transitive
    - forward-compatible
    - forward-transitive
    - full-compatible
    - full-transitive
    - reference-integrity
  rule_scope:
    - global
    - group
    - artifact
---

# Registry rules

Rules govern whether new artifact content can be added to Apicurio Registry. They are evaluated when an artifact or artifact version is created.

The core rule types are:

- Validity: checks that content is syntactically and semantically valid for its artifact type.
- Compatibility: checks whether a new version is compatible with previous content.
- Integrity: checks reference consistency, such as duplicate or missing artifact references.

Rules can be configured at multiple scopes. Precedence is artifact-specific, then group-specific, then global. A lower scope can override a higher scope by configuring the same rule and setting it to `NONE`.

In the map, rules are the center of the safe-schema-change path: they turn schema evolution from an informal review process into an enforceable gate at content ingestion time.
