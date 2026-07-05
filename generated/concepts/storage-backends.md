---
type: Concept
title: Storage backends
id: apicurio-concept-storage-backends
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/README.md
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-deploying-registry-operator.adoc
tags:
  - apicurio
  - concept
  - storage
related:
  - apicurio-resource-apicurio-registry3
  - apicurio-architecture-platform-fit
decision:
  storage:
    - embedded-h2
    - postgresql
    - mysql
    - kafkasql
    - kubernetesops
  deployment_environment:
    - local-dev
    - kubernetes
    - openshift
    - production-ha
---

# Storage backends

Apicurio Registry supports multiple storage variants. The README describes `apicurio.storage.kind` as the selector for runtime storage kind, with `sql`, `kafkasql`, and `gitops` values. Operator documentation also covers Kubernetes deployment storage options.

Documented deployment options include:

- Embedded H2 database: suitable for development and testing only.
- PostgreSQL: suitable for production deployments.
- MySQL: suitable for production deployments.
- KafkaSQL: stores registry state through Kafka topics and rebuilds local SQL state at startup.
- KubernetesOps: read-only storage backed by Kubernetes ConfigMaps, positioned for Kubernetes-native and GitOps workflows.

The map uses storage as a platform-fit foundation: storage choice determines how the registry fits database, Kafka, GitOps, and Kubernetes operating models.
