---
type: Workflow
title: Run Registry with GitOps storage
id: apicurio-workflow-run-registry-with-gitops-storage
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/examples/gitops/README.md
  - human/apicurio-registry/examples/gitops/docker-compose.yaml
  - human/apicurio-registry/examples/gitops/pull-https/docker-compose.yaml
  - human/apicurio-registry/examples/gitops/pull-ssh/docker-compose.yaml
  - human/apicurio-registry/examples/gitops/multi-repo-pull-https/docker-compose.yaml
  - human/apicurio-registry/examples/gitops/push/docker-compose.yaml
  - human/apicurio-registry/operator/controller/src/test/resources/k8s/examples/gitops/README.md
tags:
  - apicurio
  - workflow
  - gitops
  - storage
  - docker-compose
related:
  - apicurio-concept-storage-backends
  - apicurio-workflow-deploy-registry-operator
  - apicurio-resource-apicurio-registry3
---

# Run Registry with GitOps storage

The GitOps examples show how to run Apicurio Registry with `APICURIO_STORAGE_KIND=gitops`. In this mode, registry data is loaded from Git-backed files instead of being changed through normal write operations against the Registry API. The registry is read-only from the API perspective; schemas, artifacts, groups, and rules are changed by committing or pushing files to the backing Git repository.

The examples are useful for teams that want schema governance to follow the same review, branch, and promotion model as application configuration.

## Runtime shape

All Docker Compose examples expose the same local endpoints:

- Registry API: `http://localhost:8080/apis/registry/v3`
- Registry UI: `http://localhost:8888`

The registry container runs with:

- `APICURIO_STORAGE_KIND=gitops`
- `APICURIO_FEATURES_EXPERIMENTAL_ENABLED=true`
- `APICURIO_POLLING_STORAGE_ID`, defaulting to `prod`

The polling storage ID selects which registry configuration and registry-scoped data should be loaded. The examples use `prod` by default and support `staging` with:

```bash
APICURIO_POLLING_STORAGE_ID=staging docker compose up
```

## Local-only Git repository

Apicurio Registry can run from a local Git repository without GitHub and without a sidecar. The local repository is mounted into the Registry container, and the registry polls the mounted Git working tree. Changes are made by editing files and committing them locally.

Create a local repository:

```bash
mkdir -p registry-gitops-repo
cd registry-gitops-repo
git init
```

Add a registry configuration:

```yaml
# prod.registry.yaml
$type: registry-v0
registryId: prod
globalRules:
  - ruleType: VALIDITY
    config: FULL
properties: []
```

Add an artifact definition and content file:

```yaml
# order.registry.yaml
$type: artifact-v0
registryIds: [prod]
groupId: default
artifactId: order
artifactType: AVRO
name: Order
versions:
  - version: "1.0.0"
    state: ENABLED
    content: ./order.avsc
```

```json
{
  "type": "record",
  "name": "Order",
  "namespace": "example",
  "fields": [
    {
      "name": "id",
      "type": "string"
    }
  ]
}
```

Commit the files:

```bash
git add prod.registry.yaml order.registry.yaml order.avsc
git commit -m "Add initial registry artifacts"
```

Run Registry with Docker Compose from a sibling directory or from a project root that contains `registry-gitops-repo`:

```yaml
# docker-compose.yaml
services:
  registry:
    image: quay.io/apicurio/apicurio-registry:latest-snapshot
    environment:
      QUARKUS_PROFILE: "prod"
      APICURIO_STORAGE_KIND: "gitops"
      APICURIO_FEATURES_EXPERIMENTAL_ENABLED: "true"
      APICURIO_POLLING_STORAGE_ID: "prod"
      APICURIO_POLLING_STORAGE_POLL_PERIOD: "PT5S"
      APICURIO_POLLING_STORAGE_DEBOUNCE_QUIET_PERIOD: "PT5S"
      APICURIO_POLLING_STORAGE_DEBOUNCE_MAX_WAIT_PERIOD: "PT30S"
      QUARKUS_HTTP_CORS: "true"
      QUARKUS_HTTP_CORS_ORIGINS: "*"
    volumes:
      - ./registry-gitops-repo:/repos/default:ro
    ports:
      - "8080:8080"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/health/live"]
      interval: 10s
      timeout: 3s
      retries: 10
      start_period: 30s

  registry-ui:
    image: quay.io/apicurio/apicurio-registry-ui:latest-snapshot
    environment:
      REGISTRY_API_URL: http://localhost:8080/apis/registry/v3
    ports:
      - "8888:8080"
    depends_on:
      registry:
        condition: service_healthy
```

Start the stack:

```bash
docker compose up
```

To update the registry data, edit the local GitOps files, commit the changes, and wait for the next poll cycle:

```bash
git add .
git commit -m "Update registry artifacts"
```

This flow keeps all artifact storage local. There is no remote repository and no `git push` step.

## Example modes

The local volume example clones the sample GitOps repository into `examples/gitops/example-repo` and mounts it read-only into the registry at `/repos/default`. It does not use the GitOps sync sidecar. This is the smallest setup for trying GitOps storage and observing reload behavior after local file changes.

The HTTPS pull example adds the `apicurio-registry-gitops-sync` sidecar. The sidecar clones or fetches a public repository over HTTPS into a shared Docker volume, and the registry reads that volume as `/repos`.

The SSH pull example is for private repositories. The sidecar reads an SSH key from `pull-ssh/secrets/id_ed25519`, can use `secrets/known_hosts`, and pulls the repository specified by `APICURIO_GITOPS_REPO_URL`.

The multi-repo HTTPS pull example aggregates two source directories into one registry instance. The sidecar checks out the sample repository `main` branch into the `platform` directory and the `fulfillment` branch into the `fulfillment` directory. The registry is configured with matching `APICURIO_GITOPS_REPOS_0_DIR` and `APICURIO_GITOPS_REPOS_1_DIR` values so both directories are loaded.

The push example reverses the direction of Git access. The sidecar runs in push mode, exposes SSH on port `2222`, and accepts `git push` into `/repos/default`. This is useful when CI/CD or a restricted network should push schema changes to the registry sidecar instead of letting the sidecar pull from an external Git host.

## Data model

GitOps data is described with `*.registry.yaml` metadata files plus referenced schema or API content files.

A registry configuration file uses `$type: registry-v0`, identifies the `registryId`, and can define global rules such as `VALIDITY: FULL`.

A group definition uses `$type: group-v0`, declares a `groupId`, and can limit loading to specific registry instances with `registryIds`. If `registryIds` is omitted or empty, the group is loaded by all registry instances.

An artifact definition uses `$type: artifact-v0`, declares the target group and artifact ID, sets an `artifactType`, and lists versions. Each version points at a content file, for example an Avro, JSON Schema, OpenAPI, AsyncAPI, Protobuf, GraphQL, XML Schema, or WSDL file.

The optional `createdOn` and `modifiedOn` values can be date strings, timestamp strings with offsets, UTC-assumed local timestamp strings, or Unix milliseconds. If omitted, the loader falls back to the Git commit time.

## Kubernetes and OpenShift

The Docker Compose examples have matching operator-oriented examples under `operator/controller/src/test/resources/k8s/examples/gitops/`. Those examples cover local volume, pull over HTTPS, pull over SSH, multi-repo pull, and push deployments using the `ApicurioRegistry3` custom resource.

Use the Docker Compose files for local exploration. Use the operator examples when validating how GitOps storage is expressed as Kubernetes or OpenShift deployment configuration.
