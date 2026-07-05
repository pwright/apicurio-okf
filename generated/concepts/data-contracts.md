---
type: Concept
title: Data contracts
id: apicurio-concept-data-contracts
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-data-contracts.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-confluent-schema-registry-compatibility.adoc
tags:
  - apicurio
  - concept
  - data-contracts
related:
  - apicurio-concept-registry-rules
  - apicurio-concept-artifact-types
  - apicurio-concept-kafka-serdes
---

# Data contracts

Apicurio Registry supports data contracts using ODCS v3.1 as the native contract format. A contract is submitted as an ODCS YAML document, stored as an `ODCS_CONTRACT` artifact, and projected onto referenced schema artifacts.

The projection model turns contract content into registry metadata and enforcement inputs:

- Contract status, ownership, classification, support, freshness, and SLA data become namespaced labels.
- Quality rules become CEL contract rules prefixed with the contract ID.
- Field tags such as PII and classification labels become version labels.
- Multiple contracts can reference the same schema because projections are namespaced by contract ID.

Data contracts are an explicit opt-in action. The docs state that no special configuration is required to submit contracts.

In the map, data contracts connect safe schema change, compliance meaning, runtime contract enforcement, and AI/data tooling.

