---
type: Architecture
title: Platform fit
id: apicurio-architecture-platform-fit
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/README.md
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-deploying-registry-operator.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-configuring-the-registry.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-implementing-multitenancy.adoc
tags:
  - apicurio
  - architecture
  - platform
related:
  - apicurio-resource-apicurio-registry3
  - apicurio-concept-storage-backends
  - apicurio-workflow-deploy-registry-operator
decision:
  deployment_environment:
    - docker
    - kubernetes
    - openshift
    - production-ha
  storage:
    - embedded-h2
    - postgresql
    - mysql
    - kafkasql
    - kubernetesops
---

# Platform fit

Apicurio Registry is designed to fit several platform operating models rather than requiring a single deployment shape.

Source-backed platform dimensions include:

- Kubernetes and OpenShift deployment through the Operator and `ApicurioRegistry3`.
- Storage choices across SQL, KafkaSQL, GitOps, KubernetesOps, and development-only in-memory/H2 paths.
- Authentication and authorization through OIDC-oriented configuration.
- Observability through OpenTelemetry, Prometheus metrics, health checks, and structured logs.
- Multitenancy patterns using separate registry instances, storage isolation, namespace-per-tenant deployment, and group-level logical isolation.
- UI and API components that can be configured independently.

In the Blockscape map, platform fit is the bridge between registry capability and platform ownership. The registry becomes a managed platform service when storage, auth, observability, tenancy, and deployment are controlled declaratively.
