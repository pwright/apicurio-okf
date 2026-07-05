---
type: Concept
title: Flink catalog integration
id: apicurio-concept-flink-catalog
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-using-flink-catalog.adoc
tags:
  - apicurio
  - concept
  - flink
related:
  - apicurio-concept-registry-artifact-model
  - apicurio-concept-iceberg-catalog
---

# Flink catalog integration

Apicurio Registry can be used as an Apache Flink catalog. The docs map registry groups to Flink databases and registry artifacts to Flink tables.

The integration lets Flink SQL and Table API applications discover schemas directly through registry concepts. Schema content, such as Avro and JSON Schema, is converted into Flink's type system.

This is a data-tooling bridge: registry metadata becomes queryable through a stream-processing tool, so teams can manage schema definitions in one place while using them in Flink-native workflows.

