---
type: Concept
title: Registry artifact model
id: apicurio-concept-registry-artifact-model
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-intro-to-the-registry.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-registry-concepts-glossary.adoc
tags:
  - apicurio
  - concept
  - artifact-model
related:
  - apicurio-concept-artifact-types
  - apicurio-concept-registry-rules
  - apicurio-workflow-manage-artifacts-rest-api
---

# Registry artifact model

Apicurio Registry stores event schemas and API designs as artifacts. An artifact belongs to a group, has an artifact ID and type, and acts as the container for one or more immutable artifact versions.

The main identity layers are:

- Group: a namespace for related artifacts. If none is specified, the default group is used.
- Artifact: a named schema or API definition identified by `groupId` and `artifactId`.
- Artifact version: an immutable content snapshot with version metadata, lifecycle state, `globalId`, and `contentId`.
- Content: the schema or API payload. Identical content can be deduplicated and share a `contentId`.
- Branch: a named ordered sequence of versions, used to track parallel evolution paths.
- Artifact reference: a relationship from one artifact to another, such as JSON Schema `$ref`, Protobuf `import`, or Avro type references.

This model supports the "shared definitions" map outcome: teams can organize definitions, preserve version history, retrieve content by stable IDs, and model dependencies between schemas or API designs.

