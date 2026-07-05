---
type: Concept
title: Custom artifact types
id: apicurio-concept-custom-artifact-types
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/partials/getting-started/ref-registry-all-configs.adoc
  - human/apicurio-registry/common/src/main/java/io/apicurio/registry/config/artifactTypes/ArtifactTypesConfiguration.java
  - human/apicurio-registry/common/src/main/java/io/apicurio/registry/config/artifactTypes/ArtifactTypeConfiguration.java
  - human/apicurio-registry/common/src/main/java/io/apicurio/registry/config/artifactTypes/Provider.java
  - human/apicurio-registry/common/src/main/java/io/apicurio/registry/config/artifactTypes/JavaClassProvider.java
  - human/apicurio-registry/common/src/main/java/io/apicurio/registry/config/artifactTypes/WebhookProvider.java
  - human/apicurio-registry/app/src/main/java/io/apicurio/registry/types/provider/configured/ArtifactTypeUtilProviderImpl.java
  - human/apicurio-registry/app/src/main/java/io/apicurio/registry/types/provider/configured/ConfiguredArtifactTypeUtilProvider.java
  - human/apicurio-registry/common/src/test/java/io/apicurio/registry/config/artifactTypes/ArtifactTypesConfigurationTest.java
  - human/apicurio-registry/app/src/test/java/io/apicurio/registry/customTypes/NoContentCustomArtifactTestProfile.java
  - human/apicurio-registry/app/src/test/java/io/apicurio/registry/customTypes/JavaClassArtifactTypesTestProfile.java
  - human/apicurio-registry/app/src/test/java/io/apicurio/registry/customTypes/WebhookArtifactTypesTestProfile.java
  - human/apicurio-registry/common/src/main/resources/META-INF/artifact-type-webhooks.json
tags:
  - apicurio
  - concept
  - artifact-types
  - extensibility
related:
  - apicurio-concept-artifact-types
  - apicurio-concept-registry-rules
  - apicurio-workflow-manage-artifacts-rest-api
  - apicurio-workflow-register-blockscape-custom-artifact-type
---

# Custom artifact types

Apicurio Registry can load a configured set of supported artifact types from a JSON file. The runtime property is `apicurio.artifact-types.config-file`, which defaults to `/tmp/apicurio-registry-artifact-types.json`.

If the file exists, Registry parses it and builds its artifact type providers from that configuration. If the file does not exist, Registry uses the standard built-in artifact type providers.

## Configuration shape

The top-level configuration controls whether standard built-in artifact types are included and then lists additional configured types:

```json
{
  "includeStandardArtifactTypes": true,
  "artifactTypes": [
    {
      "artifactType": "RAML",
      "name": "RAML",
      "description": "RAML API description",
      "contentTypes": [
        "application/json",
        "application/x-yaml"
      ]
    }
  ]
}
```

Set `includeStandardArtifactTypes` to `true` to add custom types beside the built-in types. Set it to `false` when the instance should expose only the configured list.

Each configured artifact type must have a non-empty `artifactType` and `name`. Duplicate `artifactType` values are rejected at startup.

## Default behavior

A custom artifact type can be declared with only metadata and content types. In that case, Registry installs no-op behavior for most type-specific operations:

- content acceptance defaults to no-op acceptance,
- compatibility checking defaults to no-op compatibility,
- canonicalization defaults to returning content unchanged,
- validation defaults to no-op validation,
- dereferencing defaults to no-op dereferencing,
- reference finding defaults to no references.

This is enough to store and retrieve content using a new artifact type name, but it does not provide format-specific validation, compatibility rules, canonicalization, or reference discovery.

## Extension hooks

Configured artifact types can provide implementations for these hooks:

- `contentAccepter`
- `compatibilityChecker`
- `contentCanonicalizer`
- `contentValidator`
- `contentDereferencer`
- `referenceFinder`

They can also set `supportsReferencesWithContext` to indicate support for reference handling with context.

Each hook is configured as a provider. The supported provider types are `java` and `webhook`.

## Java providers

A Java provider names a class that implements the corresponding Registry utility contract:

```json
{
  "includeStandardArtifactTypes": true,
  "artifactTypes": [
    {
      "artifactType": "RAML",
      "name": "RAML",
      "description": "RAML API description",
      "contentTypes": [
        "application/json",
        "application/x-yaml"
      ],
      "contentAccepter": {
        "type": "java",
        "classname": "org.example.RamlContentAccepter"
      },
      "contentValidator": {
        "type": "java",
        "classname": "org.example.RamlContentValidator"
      },
      "compatibilityChecker": {
        "type": "java",
        "classname": "org.example.RamlCompatibilityChecker"
      }
    }
  ]
}
```

Use Java providers when the implementation should run inside the Registry process and can be packaged on the application classpath.

## Webhook providers

A webhook provider delegates a hook to an HTTP endpoint:

```json
{
  "includeStandardArtifactTypes": true,
  "artifactTypes": [
    {
      "artifactType": "RAML",
      "name": "RAML",
      "description": "RAML API description",
      "contentTypes": [
        "application/json",
        "application/x-yaml"
      ],
      "contentValidator": {
        "type": "webhook",
        "url": "https://example.com/registry-hooks/contentValidator",
        "headers": {
          "Authorization": "Bearer YOUR_SECRET_TOKEN",
          "Content-Type": "application/json"
        }
      },
      "compatibilityChecker": {
        "type": "webhook",
        "url": "https://example.com/registry-hooks/compatibilityChecker"
      }
    }
  ]
}
```

Use webhook providers when validation or compatibility behavior should live outside Registry, for example in a separately deployed service. The source tree includes an OpenAPI description of the webhook contracts for content acceptance, canonicalization, validation, compatibility checking, dereferencing, and reference finding.

## Operational notes

The artifact type configuration is loaded during Registry startup. Changing the configuration file requires a Registry restart.

The custom type name is the value clients use as the artifact type when creating artifacts. For example, a configured `RAML` type is addressed as `RAML`, just like built-in types such as `AVRO`, `JSON`, or `OPENAPI`.

Configured custom types integrate with the admin artifact type listing because the configured provider becomes part of the active provider set for that Registry instance.

Custom types are an extensibility mechanism for content handling. They do not automatically make the Registry UI, SDKs, or external tools understand the new format semantically; those clients still need their own support if they should provide format-aware behavior.
