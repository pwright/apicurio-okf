---
type: Concept
title: Usage telemetry
id: apicurio-concept-usage-telemetry
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-usage-telemetry.adoc
tags:
  - apicurio
  - concept
  - lifecycle
  - telemetry
related:
  - apicurio-resource-usage-telemetry-api
  - apicurio-workflow-deprecate-schema-version
  - apicurio-concept-schema-resolution
---

# Usage telemetry

Usage telemetry tracks which client applications fetch which schema versions. It is server-side and client opt-in: clients identify themselves with `X-Registry-Client-Id`, and may also send `X-Registry-Operation`.

Telemetry supports lifecycle governance questions:

- Is a schema active, stale, or dead?
- Which clients use which versions?
- Is a version safe to deprecate?
- Are consumers drifting behind the latest version?

Both `globalId` and `contentId` fetch paths are tracked. Referenced schemas can inherit liveness from schemas that reference them.

The feature is experimental in the source docs. It requires `apicurio.features.experimental.enabled=true` and telemetry-specific server configuration.

