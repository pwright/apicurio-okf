---
type: Concept
title: Confluent compatibility API
id: apicurio-concept-confluent-compatibility
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-confluent-schema-registry-compatibility.adoc
tags:
  - apicurio
  - concept
  - compatibility
  - kafka
related:
  - apicurio-concept-kafka-serdes
  - apicurio-concept-schema-resolution
  - apicurio-concept-data-contracts
decision:
  registry_goal:
    - confluent-migration
  artifact_family:
    - event-schema
  artifact_type:
    - AVRO
    - JSON
    - PROTOBUF
  consumer:
    - confluent-client
  api_mode:
    - confluent-v7
    - confluent-v8
---

# Confluent compatibility API

Apicurio Registry implements a Confluent Schema Registry compatibility layer so applications using Confluent clients can point at Apicurio instead.

The docs describe support for:

- v7 and v8 compatibility endpoints under `/apis/ccompat/...`,
- schema, subject, compatibility, config, mode, and context APIs,
- Avro, JSON Schema, and Protobuf schema types,
- pagination and v8 unknown-property behavior,
- schema ID mapping using either content ID mode or legacy global ID mode.

The compatibility layer is a migration surface. It lets teams adopt Apicurio without changing every existing schema registry client immediately.

Native Apicurio features, such as data contracts, may provide richer behavior than the compatibility API exposes.
