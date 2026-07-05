---
type: Architecture
title: Runtime data exchange
id: apicurio-architecture-runtime-data-exchange
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-using-kafka-client-serdes.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-confluent-schema-registry-compatibility.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-intro-to-registry-rules.adoc
tags:
  - apicurio
  - architecture
  - runtime
related:
  - apicurio-concept-kafka-serdes
  - apicurio-concept-schema-resolution
  - apicurio-concept-confluent-compatibility
  - apicurio-concept-registry-rules
---

# Runtime data exchange

Apicurio supports runtime data exchange by keeping schema definitions in the registry while clients exchange compact identifiers or use compatibility APIs.

The runtime path is:

1. A producer resolves or registers the schema for a message.
2. The producer serializes data and includes an identifier such as `contentId` or `globalId`.
3. A consumer uses the identifier to retrieve schema content.
4. Rules and compatibility settings govern whether new versions can enter the registry.
5. Existing Confluent clients can use the ccompat endpoint during migration.

This architecture decouples message structure from application deployments. Applications can fetch schema updates at runtime while the registry enforces validity, compatibility, and reference integrity at write time.

