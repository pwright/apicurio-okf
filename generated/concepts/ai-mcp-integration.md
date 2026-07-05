---
type: Concept
title: AI and MCP integration
id: apicurio-concept-ai-mcp-integration
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-mcp-server-integration.adoc
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-llm-artifact-types-implementation.adoc
tags:
  - apicurio
  - concept
  - ai
  - mcp
related:
  - apicurio-concept-artifact-types
  - apicurio-workflow-use-mcp-server
---

# AI and MCP integration

Apicurio Registry includes an MCP server that acts as an adapter between LLM clients and the registry REST API. The MCP side uses stdio transport; the registry side uses HTTP or HTTPS configured by `REGISTRY_URL`.

The MCP server exposes operations for:

- server information,
- groups,
- artifacts,
- versions,
- dynamic configuration,
- prompt templates.

The source also describes AI/ML artifact types, especially `PROMPT_TEMPLATE` and `MODEL_SCHEMA`, and how prompt templates can be made available through MCP.

This connects the map's data-tooling-bridge theme: registry artifacts can be discovered and used by AI agents, not only by human users or Kafka clients.

