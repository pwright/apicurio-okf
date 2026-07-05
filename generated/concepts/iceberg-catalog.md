---
type: Concept
title: Iceberg REST catalog integration
id: apicurio-concept-iceberg-catalog
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-using-iceberg-catalog.adoc
tags:
  - apicurio
  - concept
  - iceberg
related:
  - apicurio-concept-registry-artifact-model
  - apicurio-concept-flink-catalog
---

# Iceberg REST catalog integration

Apicurio Registry can implement the Apache Iceberg REST Catalog API. Query engines such as Spark, Trino, ClickHouse, DuckDB, and Flink can use the registry as a catalog for Iceberg table metadata.

The documented mapping is:

- Group maps to Iceberg namespace.
- `ICEBERG_TABLE` artifact maps to Iceberg table.
- Artifact content stores TableMetadata or ViewMetadata JSON.
- Artifact version maps to a table commit.
- Group and artifact labels map to namespace and table properties.

This feature is experimental in the source docs and requires both `apicurio.features.experimental.enabled=true` and `apicurio.iceberg.enabled=true`.

