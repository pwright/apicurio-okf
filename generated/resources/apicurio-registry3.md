---
type: Resource
title: ApicurioRegistry3 custom resource
id: apicurio-resource-apicurio-registry3
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-deploying-registry-operator.adoc
tags:
  - apicurio
  - resource
  - kubernetes
related:
  - apicurio-workflow-deploy-registry-operator
  - apicurio-concept-storage-backends
---

# ApicurioRegistry3 custom resource

`ApicurioRegistry3` is the Kubernetes custom resource installed by the Apicurio Registry Operator. Platform teams use it to declare registry instances.

The source documentation describes two main component sections:

- `spec.app`: configures the registry application.
- `spec.ui`: configures the registry UI.

The custom resource can configure storage, authentication, networking, ingress, replicas, environment variables, pod templates, TLS, resource deletion behavior, version mutability, UI behavior, and related Kubernetes deployment settings.

For production, the source warns against the default embedded H2 storage and recommends configuring a production storage type such as PostgreSQL, MySQL, KafkaSQL, or KubernetesOps.

