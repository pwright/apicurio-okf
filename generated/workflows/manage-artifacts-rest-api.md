---
type: Workflow
title: Manage artifacts using the REST API
id: apicurio-workflow-manage-artifacts-rest-api
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-managing-registry-artifacts-api.adoc
tags:
  - apicurio
  - workflow
  - api
related:
  - apicurio-concept-registry-artifact-model
  - apicurio-concept-registry-rules
decision:
  registry_goal:
    - ci-cd-validation
    - runtime-validation
    - api-contract-governance
    - event-schema-governance
  consumer:
    - ci-cd
    - sdk-client
    - maven-build
  api_mode:
    - native-v3
---

# Manage artifacts using the REST API

Client applications and automation can use the Core Registry API v3 to manage schema and API artifacts.

The source workflow covers these tasks:

- add and retrieve artifacts,
- add and retrieve artifact versions,
- manage artifact references,
- export and import registry content.

The examples create Avro schema artifacts under `/apis/registry/v3/groups/{groupId}/artifacts`, then retrieve version content through artifact and version paths.

This workflow is the automation counterpart to the web UI: it lets CI/CD pipelines and application tooling publish definitions without manual console steps.
