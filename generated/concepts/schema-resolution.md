---
type: Concept
title: Schema resolution
id: apicurio-concept-schema-resolution
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-using-kafka-client-serdes.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-registry-concepts-glossary.adoc
tags:
  - apicurio
  - concept
  - runtime
related:
  - apicurio-concept-kafka-serdes
  - apicurio-concept-registry-artifact-model
---

# Schema resolution

Schema resolution is the runtime process of finding the registry artifact version that matches data being serialized or deserialized.

Apicurio supports multiple identifiers:

- `globalId`: a unique ID for an artifact version.
- `contentId`: a unique ID for a piece of content, deduplicated across identical payloads.
- artifact reference: group, artifact, and optionally version metadata returned by a resolver strategy.

For Kafka SerDes, a resolver strategy can look up an existing artifact version or register one when missing, depending on configuration. Message payloads or headers can carry the ID that the consumer uses to retrieve the schema.

This is a foundation for safe runtime exchange because clients can move compact IDs with messages while the full schema remains managed in the registry.

