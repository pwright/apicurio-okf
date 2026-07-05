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
  - human/apicurio-registry/operator/model/src/main/java/io/apicurio/registry/operator/api/v1/ApicurioRegistry3Spec.java
  - human/apicurio-registry/operator/model/src/main/java/io/apicurio/registry/operator/api/v1/spec/AppSpec.java
  - human/apicurio-registry/operator/model/src/main/java/io/apicurio/registry/operator/api/v1/spec/UiSpec.java
  - human/apicurio-registry/operator/model/src/main/java/io/apicurio/registry/operator/api/v1/spec/ComponentSpec.java
  - human/apicurio-registry/operator/model/src/main/java/io/apicurio/registry/operator/api/v1/spec/StorageSpec.java
  - human/apicurio-registry/operator/model/src/main/java/io/apicurio/registry/operator/api/v1/spec/auth/AuthSpec.java
  - human/apicurio-registry/operator/controller/src/test/resources/k8s/examples/postgresql/example-postgresql.apicurioregistry3.yaml
  - human/apicurio-registry/operator/controller/src/test/resources/k8s/examples/gitops/example-pull-https.yaml
  - human/apicurio-registry/operator/controller/src/test/resources/k8s/examples/kubernetesops/example-full.yaml
  - human/apicurio-registry/operator/controller/src/test/resources/k8s/examples/podtemplatespec/podtemplatespec.apicurioregistry3.yaml
tags:
  - apicurio
  - resource
  - kubernetes
  - operator
related:
  - apicurio-workflow-deploy-registry-operator
  - apicurio-concept-storage-backends
  - apicurio-workflow-run-registry-with-gitops-storage
---

# ApicurioRegistry3 custom resource

`ApicurioRegistry3` is the Kubernetes custom resource installed by the Apicurio Registry Operator. Platform teams use it to declare registry instances.

The CR has two main component sections:

- `spec.app`: configures the registry application.
- `spec.ui`: configures the registry UI.

The custom resource can configure storage, authentication, networking, ingress, replicas, environment variables, pod templates, TLS, resource deletion behavior, version mutability, UI behavior, and related Kubernetes deployment settings.

For production, the source warns against the default embedded H2 storage and recommends configuring a production storage type such as PostgreSQL, MySQL, KafkaSQL, or KubernetesOps.

## Top-level shape

```yaml
apiVersion: registry.apicur.io/v1
kind: ApicurioRegistry3
metadata:
  name: example
spec:
  app:
    storage: {}
    ingress: {}
    env: []
  ui:
    enabled: true
    ingress: {}
```

Both `spec.app` and `spec.ui` inherit common component settings:

- `env`: environment variables passed to the component container.
- `ingress`: operator-managed Ingress or Route settings.
- `podTemplateSpec`: Kubernetes pod template customizations merged into the generated Deployment.
- `replicas`: static replica count.
- `autoscaling`: HorizontalPodAutoscaler configuration.
- `podDisruptionBudget`: operator-managed PDB toggle.
- `networkPolicy`: operator-managed NetworkPolicy toggle.
- `host`: deprecated shortcut; use `ingress.host`.

## Storage

Storage is configured under `spec.app.storage`.

Supported `type` values are:

- empty or omitted: embedded/in-memory SQL storage for development only.
- `postgresql`: SQL storage using PostgreSQL.
- `mysql`: SQL storage using MySQL.
- `kafkasql`: Kafka-backed journal with local SQL state rebuilt at startup.
- `kubernetesops`: read-only storage loaded from Kubernetes ConfigMaps.
- `gitops`: read-only storage loaded from Git through the GitOps sync sidecar.

PostgreSQL and MySQL use `spec.app.storage.sql.dataSource`:

```yaml
spec:
  app:
    storage:
      type: postgresql
      sql:
        dataSource:
          url: jdbc:postgresql://postgresql:5432/registry
          username: registry
          password:
            name: postgresql-credentials
            key: password
```

KafkaSQL uses `spec.app.storage.kafkasql`:

```yaml
spec:
  app:
    storage:
      type: kafkasql
      kafkasql:
        bootstrapServers: my-cluster-kafka-bootstrap:9092
```

KafkaSQL can also configure:

- `kafkaAccessSecretName`: Strimzi Kafka Access Operator service binding secret.
- `tls`: keystore and truststore secret references.
- `auth`: SASL/OAuth settings such as `enabled`, `mechanism`, `clientIdRef`, `clientSecretRef`, `tokenEndpoint`, and `loginHandlerClass`.

KubernetesOps storage uses ConfigMaps:

```yaml
spec:
  app:
    storage:
      type: kubernetesops
      kubernetesops:
        registryId: my-registry
        namespace: apicurio
        refreshEvery: 10s
        labelRegistryId: custom.label/registry
        watchEnabled: false
        watchReconnectDelay: 5s
```

GitOps storage uses Git repositories:

```yaml
spec:
  app:
    storage:
      type: gitops
      gitops:
        registryId: prod
        repos:
          - url: https://github.com/Apicurio/apicurio-registry-gitops-example.git
            branch: main
            dir: default
```

GitOps supports `mode: pull` or `mode: push`. Pull mode can configure `pull.sshKeys` and `pull.knownHosts` secret refs for private repositories. Push mode can configure `push.authorizedKeys` and `push.hostKey`; the operator creates an SSH service on port `2222`.

## Ingress and TLS

Ingress is configured per component:

```yaml
spec:
  app:
    ingress:
      host: registry.example.com
      ingressClassName: nginx
      annotations:
        nginx.ingress.kubernetes.io/proxy-body-size: 10m
      tlsSecretName: registry-tls
      tlsTermination: edge
  ui:
    ingress:
      host: registry-ui.example.com
```

Useful ingress fields are:

- `enabled`: set `false` to manage Ingress or Route yourself.
- `host`: hostname for the operator-managed resource.
- `annotations`: extra annotations.
- `ingressClassName`: target IngressClass.
- `tlsSecretName`: Kubernetes TLS Secret for ingress TLS.
- `tlsTermination`: `edge`, `passthrough`, or `reencrypt`; on OpenShift this also controls Route TLS termination.

Application-level TLS is configured with `spec.app.tls`:

```yaml
spec:
  app:
    tls:
      insecureRequests: redirect
      keystoreSecretRef:
        name: registry-tls
        key: tls.p12
      keystorePasswordSecretRef:
        name: registry-tls
        key: password
```

Use ingress `tlsTermination: edge` when TLS terminates at the router or ingress controller. Use app-level TLS with passthrough when the registry application should handle HTTPS directly.

## Authentication and authorization

Authentication is configured under `spec.app.auth`:

```yaml
spec:
  app:
    auth:
      enabled: true
      appClientId: registry-api
      uiClientId: apicurio-registry
      authServerUrl: https://keycloak.example.com/realms/registry
      redirectUri: https://registry-ui.example.com
      logoutUrl: https://registry-ui.example.com
      anonymousReadsEnabled: true
      basicAuth:
        enabled: true
        cacheExpiration: 25m
      tls:
        tlsVerificationType: none
```

Authentication configurables include:

- OIDC endpoints and client IDs: `authServerUrl`, `appClientId`, `uiClientId`.
- UI redirect behavior: `redirectUri`, `logoutUrl`.
- anonymous read access: `anonymousReadsEnabled`.
- client credentials basic auth: `basicAuth.enabled`, `basicAuth.cacheExpiration`.
- OIDC TLS trust: `tls.tlsVerificationType`, `tls.truststoreSecretRef`, `tls.truststorePasswordSecretRef`.

Authorization is nested under `spec.app.auth.authz`:

- `enabled`: enable role-based authorization.
- `ownerOnlyEnabled`: only artifact owners can modify or delete their artifacts.
- `groupAccessEnabled`: group creator controls write access to that group.
- `readAccessEnabled`: authenticated users get at least read access.
- `roles.source`, `roles.admin`, `roles.developer`, `roles.readOnly`: role source and names.
- `adminOverride`: token role or claim-based admin override.

## App features

`spec.app.features` configures selected Registry behavior:

```yaml
spec:
  app:
    features:
      resourceDeleteEnabled: true
      versionMutabilityEnabled: true
```

- `resourceDeleteEnabled`: enables deletes for groups, artifacts, and artifact versions.
- `versionMutabilityEnabled`: allows DRAFT artifact versions to be mutable and unlocks related Studio UI behavior.

For finer-grained application configuration, use `spec.app.env` to pass Registry environment variables directly.

## UI

`spec.ui.enabled` controls whether the operator deploys the UI component. The UI also supports the common component fields: `env`, `ingress`, `replicas`, `autoscaling`, `podTemplateSpec`, `podDisruptionBudget`, and `networkPolicy`.

```yaml
spec:
  ui:
    enabled: false
```

Use `spec.ui.env` for UI-specific environment variables when the operator does not expose a dedicated CR field.

## Scheduling and pod customization

Use `podTemplateSpec` when you need Kubernetes-native pod changes such as volumes, mounts, tolerations, node selectors, affinity, security context, annotations, or sidecar-related customization.

```yaml
spec:
  app:
    env:
      - name: APICURIO_IMPORT_URL
        value: file:///tmp/export/export.zip
    podTemplateSpec:
      spec:
        containers:
          - name: apicurio-registry-app
            volumeMounts:
              - name: export-data
                mountPath: /tmp/export
                readOnly: true
        volumes:
          - name: export-data
            configMap:
              name: export-data
```

Container names matter when patching generated containers. The app container name is `apicurio-registry-app`.

## Scaling and availability

For static scale:

```yaml
spec:
  app:
    replicas: 3
```

For autoscaling:

```yaml
spec:
  app:
    autoscaling:
      enabled: true
      minReplicas: 2
      maxReplicas: 6
      targetCPUUtilizationPercentage: 80
      targetMemoryUtilizationPercentage: 75
```

When autoscaling is enabled, the static `replicas` field is ignored. `podDisruptionBudget.enabled` and `networkPolicy.enabled` default to operator-managed behavior and can be set to `false` if the platform team manages those resources separately.

## Observability and search

OpenTelemetry is configured under `spec.app.otel`:

```yaml
spec:
  app:
    otel:
      enabled: true
      endpoint: http://otel-collector:4317
      protocol: grpc
      traceSamplingRatio: 0.1
```

Elasticsearch-based content search indexing is configured under `spec.app.searchIndex`:

```yaml
spec:
  app:
    searchIndex:
      enabled: true
      hosts: elasticsearch:9200
      indexName: apicurio-registry
      username: registry
      password:
        name: elasticsearch-credentials
        key: password
```

## Practical rule

Prefer first-class CR fields for storage, ingress, TLS, auth, scaling, and observability. Use `env` for Registry configuration properties that do not have a dedicated CR field. Use `podTemplateSpec` when the desired change is really a Kubernetes pod/deployment concern rather than a Registry setting.
