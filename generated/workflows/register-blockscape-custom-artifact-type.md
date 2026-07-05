---
type: Workflow
title: Register Blockscape as a custom artifact type
id: apicurio-workflow-register-blockscape-custom-artifact-type
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - prompts/generate-blockscape.md
  - human/apicurio-registry/docs/modules/ROOT/partials/getting-started/ref-registry-all-configs.adoc
  - human/apicurio-registry/app/src/main/java/io/apicurio/registry/types/provider/configured/ArtifactTypeUtilProviderImpl.java
  - human/apicurio-registry/app/src/main/java/io/apicurio/registry/types/provider/configured/ConfiguredArtifactTypeUtilProvider.java
  - human/apicurio-registry/common/src/test/java/io/apicurio/registry/config/artifactTypes/ArtifactTypesConfigurationTest.java
  - human/apicurio-registry/app/src/test/java/io/apicurio/registry/customTypes/WebhookArtifactTypesTestProfile.java
  - human/apicurio-registry/common/src/main/resources/META-INF/artifact-type-webhooks.json
tags:
  - apicurio
  - workflow
  - artifact-types
  - blockscape
  - validation
related:
  - apicurio-concept-custom-artifact-types
  - apicurio-concept-artifact-types
  - apicurio-concept-registry-rules
  - apicurio-workflow-manage-artifacts-rest-api
---

# Register Blockscape as a custom artifact type

This workflow shows how to model Blockscape `.bs` files as a custom Apicurio Registry artifact type. The `.bs` content is JSON generated from the local Blockscape prompt shape:

```text
{ id, title, abstract?, categories:[{id,title,items:[{id,name,deps?:[],logo?,external?:url,color?,stage?:1-4,...}]}] }
```

The important validation rule is that `.bs` files may contain extra fields, but they must still adhere to the required Blockscape shape. That means the validator should require the structural fields used by Blockscape while allowing additional metadata fields at the map, category, and item levels.

## Artifact type configuration

Create an artifact type config file and mount it into Registry at the path configured by `apicurio.artifact-types.config-file`.

```json
{
  "includeStandardArtifactTypes": true,
  "artifactTypes": [
    {
      "artifactType": "BLOCKSCAPE",
      "name": "Blockscape",
      "description": "Blockscape map JSON stored in .bs files.",
      "contentTypes": [
        "application/json",
        "application/blockscape+json",
        "text/plain"
      ],
      "contentValidator": {
        "type": "webhook",
        "url": "http://blockscape-validator:3000/contentValidator"
      }
    }
  ]
}
```

The custom type is named `BLOCKSCAPE`. The `contentValidator` hook is what makes the `VALIDITY` rule useful for this custom type. Without a custom validator, configured custom artifact types use no-op validation.

## Blockscape shape schema

The validator can enforce this JSON Schema. The schema permits extra fields with `additionalProperties: true`, but requires the core shape.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://example.com/schemas/blockscape-map.schema.json",
  "title": "Blockscape map",
  "oneOf": [
    {
      "$ref": "#/$defs/map"
    },
    {
      "type": "array",
      "items": {
        "$ref": "#/$defs/map"
      },
      "minItems": 1
    }
  ],
  "$defs": {
    "map": {
      "type": "object",
      "required": [
        "id",
        "title",
        "categories"
      ],
      "additionalProperties": true,
      "properties": {
        "id": {
          "type": "string",
          "minLength": 1
        },
        "title": {
          "type": "string",
          "minLength": 1
        },
        "abstract": {
          "type": "string"
        },
        "categories": {
          "type": "array",
          "minItems": 1,
          "items": {
            "$ref": "#/$defs/category"
          }
        }
      }
    },
    "category": {
      "type": "object",
      "required": [
        "id",
        "title",
        "items"
      ],
      "additionalProperties": true,
      "properties": {
        "id": {
          "type": "string",
          "minLength": 1
        },
        "title": {
          "type": "string",
          "minLength": 1
        },
        "items": {
          "type": "array",
          "items": {
            "$ref": "#/$defs/item"
          }
        }
      }
    },
    "item": {
      "type": "object",
      "required": [
        "id",
        "name"
      ],
      "additionalProperties": true,
      "properties": {
        "id": {
          "type": "string",
          "minLength": 1
        },
        "name": {
          "type": "string",
          "minLength": 1
        },
        "deps": {
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "logo": {
          "type": "string"
        },
        "external": {
          "type": "string",
          "format": "uri"
        },
        "color": {
          "type": "string"
        },
        "stage": {
          "type": "integer",
          "minimum": 1,
          "maximum": 4
        }
      }
    }
  }
}
```

The `oneOf` allows either a single Blockscape map object or an array of maps. Use only the object branch if the Registry instance should reject multi-map `.bs` files.

## Compose example

This Compose file runs Registry with the custom artifact type config and a separate validator service. The validator service is responsible for implementing the webhook contract from `artifact-type-webhooks.json`.

```yaml
services:
  registry:
    image: quay.io/apicurio/apicurio-registry:latest-snapshot
    environment:
      QUARKUS_PROFILE: "prod"
      APICURIO_ARTIFACT_TYPES_CONFIG_FILE: "/config/artifact-types.json"
    volumes:
      - ./artifact-types.json:/config/artifact-types.json:ro
    ports:
      - "8080:8080"
    depends_on:
      - blockscape-validator

  registry-ui:
    image: quay.io/apicurio/apicurio-registry-ui:latest-snapshot
    environment:
      REGISTRY_API_URL: http://localhost:8080/apis/registry/v3
    ports:
      - "8888:8080"
    depends_on:
      - registry

  blockscape-validator:
    image: node:22-alpine
    working_dir: /app
    volumes:
      - ./validator:/app:ro
    command: ["node", "server.js"]
    ports:
      - "3000:3000"
```

## Validity rule

After Registry starts with the `BLOCKSCAPE` custom type, configure a `VALIDITY` rule so new versions are checked by the custom validator.

For a global rule that applies before the first `.bs` artifact is created:

```bash
curl -X POST \
  http://localhost:8080/apis/registry/v3/admin/rules \
  -H "Content-Type: application/json" \
  -d '{"ruleType":"VALIDITY","config":"FULL"}'
```

For an artifact-specific rule after the artifact already exists:

```bash
curl -X POST \
  http://localhost:8080/apis/registry/v3/groups/default/artifacts/apicurio-map/rules \
  -H "Content-Type: application/json" \
  -d '{"ruleType":"VALIDITY","config":"FULL"}'
```

Use an artifact-specific rule when only a particular `.bs` artifact should be gated this way. Use a global rule when all artifact types in the Registry should have validity enforced according to their own validators. If the rule already exists, update it with `PUT /apis/registry/v3/admin/rules/VALIDITY` or `PUT /apis/registry/v3/groups/default/artifacts/apicurio-map/rules/VALIDITY` and a body of `{"config":"FULL"}`.

## Register a `.bs` artifact

Create a Blockscape artifact with artifact type `BLOCKSCAPE`:

```bash
curl -X POST \
  "http://localhost:8080/apis/registry/v3/groups/default/artifacts?artifactId=apicurio-map" \
  -H "Content-Type: application/json" \
  -H "X-Registry-ArtifactType: BLOCKSCAPE" \
  --data-binary @maps/apicurio.bs
```

If the content is valid JSON and matches the required Blockscape shape, Registry accepts it. If required fields such as `id`, `title`, `categories`, category `items`, or item `name` are missing, the validator should reject the content and the `VALIDITY` rule should prevent the artifact version from being stored.

## GitOps variant

The same artifact type can be used from GitOps storage by setting the artifact definition to `BLOCKSCAPE`:

```yaml
$type: artifact-v0
registryIds: [prod]
groupId: default
artifactId: apicurio-map
artifactType: BLOCKSCAPE
name: Apicurio Blockscape map
versions:
  - version: "1.0.0"
    state: ENABLED
    content: ./apicurio.bs
```

In this variant, Registry still needs the custom artifact type config at startup. The `.bs` file remains ordinary JSON on disk, but the custom type gives Registry a named artifact type and a validity hook for the Blockscape shape.
