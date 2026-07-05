---
type: Workflow
title: Deploy Registry using the Operator
id: apicurio-workflow-deploy-registry-operator
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-deploying-registry-operator.adoc
tags:
  - apicurio
  - workflow
  - kubernetes
related:
  - apicurio-resource-apicurio-registry3
  - apicurio-concept-storage-backends
  - apicurio-architecture-platform-fit
---

# Deploy Registry using the Operator

The Operator workflow uses the `ApicurioRegistry3` custom resource to deploy registry instances on Kubernetes or OpenShift.

The source describes deployment variants for:

- default embedded H2 storage for development and testing,
- PostgreSQL,
- MySQL,
- KafkaSQL,
- KubernetesOps,
- authentication and TLS/OIDC,
- ingress and network policy,
- replicas, pod disruption budgets, pod templates, environment variables, and UI configuration.

The production path is storage-specific. The source warns that embedded H2 is not suitable for production and directs production deployments toward PostgreSQL, MySQL, KafkaSQL, or KubernetesOps.

