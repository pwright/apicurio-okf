---
type: Resource
title: Usage telemetry API
id: apicurio-resource-usage-telemetry-api
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-usage-telemetry.adoc
tags:
  - apicurio
  - resource
  - api
  - telemetry
related:
  - apicurio-concept-usage-telemetry
  - apicurio-workflow-deprecate-schema-version
---

# Usage telemetry API

Usage telemetry endpoints live under `/admin/usage/` and require usage telemetry to be enabled. The source states that endpoints return HTTP 409 when telemetry is not enabled.

Documented endpoints include:

- `GET /admin/usage/summary`: global active, stale, and dead counts.
- `GET /admin/usage/artifacts/{groupId}/{artifactId}`: per-version usage metrics for an artifact.
- `GET /admin/usage/artifacts/{groupId}/{artifactId}/heatmap`: consumer version adoption and drift.
- `GET /admin/usage/artifacts/{groupId}/{artifactId}/versions/{version}/deprecation-readiness`: active consumers and deprecation safety.

This API supports change-confidence workflows by exposing actual consumer usage rather than relying only on ownership records or source search.

