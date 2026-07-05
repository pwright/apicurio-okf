---
type: Workflow
title: Deprecate a schema version with telemetry
id: apicurio-workflow-deprecate-schema-version
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-usage-telemetry.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-registry-concepts-glossary.adoc
tags:
  - apicurio
  - workflow
  - lifecycle
related:
  - apicurio-concept-usage-telemetry
  - apicurio-resource-usage-telemetry-api
  - apicurio-concept-registry-artifact-model
decision:
  registry_goal:
    - compatibility-governance
  consumer:
    - runtime-client
  lifecycle_state:
    - deprecated
    - disabled
---

# Deprecate a schema version with telemetry

Usage telemetry supports a safer version deprecation workflow by showing active consumers before lifecycle state changes.

The source describes these decision points:

1. Enable experimental usage telemetry and telemetry-specific server configuration.
2. Configure clients with `apicurio.registry.usage-telemetry.client-id`, which sends `X-Registry-Client-Id` on schema fetches.
3. Use the usage summary and per-artifact metrics to classify versions as active, stale, or dead.
4. Use the heatmap to find consumers behind the latest version.
5. Use deprecation readiness for a specific artifact version to check active consumers.
6. Move the version through lifecycle states only when consumers are ready.

The source state machine includes `ENABLED`, `DEPRECATED`, `SUNSET`, and `DISABLED`. The workflow should preserve a migration window before deletion.
