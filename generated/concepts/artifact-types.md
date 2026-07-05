---
type: Concept
title: Artifact types
id: apicurio-concept-artifact-types
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-registry-concepts-glossary.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-intro-to-the-registry.adoc
tags:
  - apicurio
  - concept
  - artifact-types
related:
  - apicurio-concept-registry-artifact-model
  - apicurio-concept-data-contracts
  - apicurio-concept-ai-mcp-integration
  - apicurio-concept-custom-artifact-types
decision:
  artifact_family:
    - event-schema
    - api-contract
    - xml-contract
    - ai-agent-artifact
    - custom
  artifact_type:
    - AVRO
    - PROTOBUF
    - JSON
    - KCONNECT
    - OPENAPI
    - ASYNCAPI
    - GRAPHQL
    - WSDL
    - XML
    - XSD
    - THRIFT
    - MCP_TOOL
    - MODEL_SCHEMA
    - PROMPT_TEMPLATE
    - custom
---

# Artifact types

An artifact type identifies the format or schema language of registry content. Apicurio uses the artifact type to parse, validate, canonicalize, and check compatibility for the content.

Documented built-in types include:

- `AVRO`
- `PROTOBUF`
- `JSON`
- `OPENAPI`
- `ASYNCAPI`
- `GRAPHQL`
- `KCONNECT`
- `THRIFT`
- `WSDL`
- `XSD`
- `XML`
- `AGENT_CARD`
- `ICEBERG_TABLE`
- `ICEBERG_VIEW`

The docs also describe AI/ML-oriented types such as `MODEL_SCHEMA` and `PROMPT_TEMPLATE`, plus ODCS data contracts. These types expand the registry beyond classic schema storage into data product governance, AI agent metadata, and lakehouse catalog use cases.

Registry can also load configured custom artifact types from an artifact type configuration file. See `apicurio-concept-custom-artifact-types` for the custom type configuration model and extension hooks.
