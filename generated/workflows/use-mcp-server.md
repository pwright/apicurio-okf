---
type: Workflow
title: Use the Registry MCP server
id: apicurio-workflow-use-mcp-server
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-mcp-server-integration.adoc
tags:
  - apicurio
  - workflow
  - mcp
related:
  - apicurio-concept-ai-mcp-integration
decision:
  registry_goal:
    - ai-agent-registry
  artifact_family:
    - ai-agent-artifact
  artifact_type:
    - MCP_TOOL
    - MODEL_SCHEMA
    - PROMPT_TEMPLATE
  consumer:
    - sdk-client
    - human
---

# Use the Registry MCP server

The MCP server lets LLM clients interact with a running Apicurio Registry instance through MCP while the server translates tool calls into registry REST API calls.

The source describes two installation paths:

- run the MCP server container image,
- or build the MCP module from source with Maven.

For Claude Desktop, the user adds an MCP server entry that runs the Docker image or Java JAR. The Docker example passes `REGISTRY_URL` so the MCP server knows which registry instance to call.

The MCP server includes a safe mode enabled by default, limiting operations that could cause unintended changes.
