---
type: Concept
title: Decision Lens
id: apicurio-concept-decision-lens
status: generated
reviewed: false
source_repo: local
source_paths:
  - ../decision-lens-apicurio.md
tags:
  - apicurio
  - concept
  - decision-lens
  - llm-wiki
related:
  - apicurio-concept-artifact-types
  - apicurio-concept-registry-rules
  - apicurio-concept-storage-backends
  - apicurio-architecture-runtime-data-exchange
---

# Decision Lens

Decision Lens is a runtime soft-filter for the Apicurio Quartz wiki. A user chooses a registry profile in the browser, and the site hides navigation, search, and discovery entries that do not apply to that profile. The built static content remains present, and direct URLs can still work.

The user decision happens at runtime. Page applicability is declared ahead of time in Markdown frontmatter using `decision` metadata.

## User-facing decisions

The first Apicurio Decision Lens should follow the questions a new Registry user actually needs to answer:

1. Why does the registry exist?
2. What artifact family and artifact type are being registered?
3. Who or what consumes the artifact?
4. How strict should change governance be?
5. Is the user working through native Apicurio APIs, Confluent compatibility, CI/CD, runtime SerDes, or AI/MCP tooling?
6. What storage and deployment path is appropriate?

This is more useful than starting with storage backend or deployment mode. Storage matters, but it usually comes after artifact purpose, consumer workflow, and change policy.

## Decision metadata

Use `decision` frontmatter only when a page clearly applies to a specific registry decision. Leave generic Apicurio concepts unmarked.

Common dimensions:

```yaml
decision:
  registry_goal:
    - runtime-validation
  artifact_family:
    - event-schema
  artifact_type:
    - AVRO
  consumer:
    - kafka-serde
```

High-value dimensions:

- `registry_goal`: `runtime-validation`, `compatibility-governance`, `api-contract-governance`, `event-schema-governance`, `ci-cd-validation`, `confluent-migration`, `ai-agent-registry`, `custom-artifact-governance`
- `artifact_family`: `event-schema`, `api-contract`, `xml-contract`, `ai-agent-artifact`, `custom`
- `artifact_type`: `AVRO`, `PROTOBUF`, `JSON`, `KCONNECT`, `OPENAPI`, `ASYNCAPI`, `GRAPHQL`, `WSDL`, `XML`, `XSD`, `THRIFT`, `MCP_TOOL`, `MODEL_SCHEMA`, `PROMPT_TEMPLATE`, `custom`
- `consumer`: `human`, `ci-cd`, `runtime-client`, `kafka-serde`, `confluent-client`, `sdk-client`, `maven-build`
- `change_policy`: `none`, `validity-only`, `backward-compatible`, `backward-transitive`, `forward-compatible`, `forward-transitive`, `full-compatible`, `full-transitive`, `reference-integrity`
- `api_mode`: `native-v3`, `confluent-v7`, `confluent-v8`
- `storage`: `embedded-h2`, `postgresql`, `mysql`, `kafkasql`, `kubernetesops`
- `deployment_environment`: `local-dev`, `docker`, `kubernetes`, `openshift`, `production-ha`

## Matching rules

- If the selected profile is `all` or unset, show everything.
- If a page has no `decision` frontmatter, show it.
- If a page declares a `decision` field, show it only when the selected profile matches that field.
- Event-schema profiles should not show API-contract-only pages.
- API-contract profiles should not show Kafka SerDes-only pages.
- Production deployment profiles should not recommend embedded H2 as the main path.
- Confluent migration profiles should emphasize Confluent-compatible API material and hide unrelated native-only beginner paths where practical.

## Examples

Event schema and Kafka runtime:

```yaml
decision:
  registry_goal:
    - runtime-validation
  artifact_family:
    - event-schema
  artifact_type:
    - AVRO
    - PROTOBUF
    - JSON
  consumer:
    - kafka-serde
```

API contract governance:

```yaml
decision:
  registry_goal:
    - api-contract-governance
  artifact_family:
    - api-contract
  artifact_type:
    - OPENAPI
    - ASYNCAPI
    - GRAPHQL
```

Confluent migration:

```yaml
decision:
  registry_goal:
    - confluent-migration
  consumer:
    - confluent-client
  api_mode:
    - confluent-v7
    - confluent-v8
```

Production deployment:

```yaml
decision:
  deployment_environment:
    - production-ha
  storage:
    - postgresql
    - mysql
    - kafkasql
```

## Limits

Decision Lens is not access control. It does not remove pages from the static build, protect sensitive content, or replace authentication. It improves the normal browsing path by filtering Explorer, search, page lists, and link/card surfaces where the runtime plugin supports it.
