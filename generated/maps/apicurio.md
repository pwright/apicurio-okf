---
title: "Apicurio Blockscape maps"
type: BlockscapeMap
status: generated
source_path: maps/apicurio.bs
tags:
  - apicurio
  - blockscape
---

# Apicurio Blockscape maps

Edit: [Blockscape](https://pwright.github.io/blockscape/?load=https://raw.githubusercontent.com/pwright/apicurio-okf/refs/heads/main/maps/apicurio.bs)

```bs full
[
{
"id": "shared-definitions",
"title": "I need everyone to use the same definition of this data or API",
"abstract": "Teams often start with schemas, API specs, and message definitions scattered across repos, documents, and application code. This map shows how Apicurio creates a shared source of truth where definitions can be stored, versioned, discovered, reused, and restored.",
"categories": [
{
"id": "user-outcomes",
"title": "User Outcomes",
"items": [
{
"id": "shared-source-of-truth",
"name": "Shared Source of Truth",
"deps": [
"artifact-storage-versioning",
"multi-format-support",
"web-ui"
]
},
{
"id": "definition-discovery",
"name": "Definition Discovery",
"deps": [
"search-discovery",
"metadata-search",
"web-ui"
]
},
{
"id": "safe-reuse",
"name": "Safe Reuse Across Teams",
"deps": [
"groups",
"branches",
"references"
]
}
]
},
{
"id": "registry-capabilities",
"title": "Registry Capabilities",
"items": [
{
"id": "artifact-storage-versioning",
"name": "Artifact Storage & Versioning",
"deps": [
"content-deduplication",
"storage-backend"
]
},
{
"id": "multi-format-support",
"name": "Multi-Format Support",
"deps": [
"artifact-types"
]
},
{
"id": "search-discovery",
"name": "Search & Discovery",
"deps": [
"metadata-search",
"search-indexing"
]
},
{
"id": "import-export",
"name": "Import / Export",
"deps": [
"zip-archive",
"admin-access"
]
}
]
},
{
"id": "organization",
"title": "Organization & Access Paths",
"items": [
{
"id": "web-ui",
"name": "Web UI",
"deps": [
"registry-api"
]
},
{
"id": "client-sdks",
"name": "Multi-Language Client SDKs",
"deps": [
"registry-api"
]
},
{
"id": "groups",
"name": "Groups",
"deps": [
"registry-api"
]
},
{
"id": "branches",
"name": "Branches",
"deps": [
"artifact-storage-versioning"
]
},
{
"id": "references",
"name": "Artifact References",
"deps": [
"artifact-storage-versioning"
]
}
]
},
{
"id": "foundation",
"title": "Foundation",
"items": [
{
"id": "registry-api",
"name": "Registry REST API",
"deps": [
"storage-backend"
]
},
{
"id": "artifact-types",
"name": "Schema and API Formats",
"deps": []
},
{
"id": "metadata-search",
"name": "Metadata Search",
"deps": [
"storage-backend"
]
},
{
"id": "search-indexing",
"name": "Elasticsearch Content Indexing",
"deps": [
"elasticsearch"
]
},
{
"id": "content-deduplication",
"name": "SHA-256 Content Deduplication",
"deps": []
},
{
"id": "zip-archive",
"name": "Registry ZIP Archive",
"deps": [
"storage-backend"
]
},
{
"id": "admin-access",
"name": "Admin Access",
"deps": []
}
]
},
{
"id": "infrastructure",
"title": "Infrastructure",
"items": [
{
"id": "storage-backend",
"name": "Storage Backend",
"deps": []
},
{
"id": "elasticsearch",
"name": "Elasticsearch",
"deps": []
}
]
}
]
},
{
"id": "safe-schema-change",
"title": "I need to change schemas without breaking other teams",
"abstract": "The core fear behind schema governance is accidental breakage. This map shows how Apicurio helps teams validate definitions, control compatibility, manage references, attach contracts, and signal lifecycle intent before consumers are affected.",
"categories": [
{
"id": "user-outcomes",
"title": "User Outcomes",
"items": [
{
"id": "safe-change",
"name": "Safe Schema Change",
"deps": [
"compatibility-rules",
"validity-rules",
"data-contracts"
]
},
{
"id": "consumer-protection",
"name": "Consumer Protection",
"deps": [
"compatibility-rules",
"reference-checks",
"version-lifecycle-state"
]
},
{
"id": "governed-evolution",
"name": "Governed Evolution",
"deps": [
"rules-engine",
"contract-lifecycle",
"audit-trail"
]
}
]
},
{
"id": "governance-capabilities",
"title": "Governance Capabilities",
"items": [
{
"id": "rules-engine",
"name": "Rules Engine",
"deps": [
"global-rules",
"group-rules",
"artifact-rules"
]
},
{
"id": "compatibility-rules",
"name": "Compatibility Rules",
"deps": [
"rules-engine",
"artifact-storage-versioning"
]
},
{
"id": "validity-rules",
"name": "Validity Rules",
"deps": [
"rules-engine",
"multi-format-support"
]
},
{
"id": "reference-checks",
"name": "Reference Checks",
"deps": [
"rules-engine",
"artifact-references"
]
},
{
"id": "version-lifecycle-state",
"name": "Version Lifecycle State",
"deps": [
"artifact-storage-versioning"
]
}
]
},
{
"id": "contract-layer",
"title": "Contract Layer",
"items": [
{
"id": "data-contracts",
"name": "Data Contracts",
"deps": [
"odcs-format",
"contract-metadata",
"contract-rules"
]
},
{
"id": "contract-lifecycle",
"name": "Contract Lifecycle",
"deps": [
"data-contracts",
"version-lifecycle-state"
]
},
{
"id": "contract-rules",
"name": "Contract Rules",
"deps": [
"rules-engine",
"cel-jsonata"
]
},
{
"id": "contract-metadata",
"name": "Ownership and SLA Metadata",
"deps": [
"artifact-labels"
]
}
]
},
{
"id": "registry-foundation",
"title": "Registry Foundation",
"items": [
{
"id": "artifact-storage-versioning",
"name": "Artifact Storage & Versioning",
"deps": [
"storage-backend"
]
},
{
"id": "multi-format-support",
"name": "Multi-Format Support",
"deps": [
"artifact-types"
]
},
{
"id": "artifact-references",
"name": "Artifact References",
"deps": [
"artifact-storage-versioning"
]
},
{
"id": "artifact-labels",
"name": "Artifact Labels",
"deps": [
"storage-backend"
]
},
{
"id": "audit-trail",
"name": "Audit Trail",
"deps": [
"change-events"
]
}
]
},
{
"id": "configuration-scope",
"title": "Configuration Scope",
"items": [
{
"id": "global-rules",
"name": "Global Rules",
"deps": []
},
{
"id": "group-rules",
"name": "Group Rules",
"deps": []
},
{
"id": "artifact-rules",
"name": "Artifact Rules",
"deps": []
},
{
"id": "odcs-format",
"name": "ODCS Format",
"deps": []
},
{
"id": "cel-jsonata",
"name": "CEL and JSONata",
"deps": []
},
{
"id": "change-events",
"name": "Change Events",
"deps": [
"storage-backend"
]
},
{
"id": "storage-backend",
"name": "Storage Backend",
"deps": []
}
]
},
{
"id": "extension-points",
"title": "Extension Points",
"items": [
{
"id": "custom-artifact-types",
"name": "Custom Artifact Types",
"deps": [
"artifact-types-config"
]
},
{
"id": "artifact-types",
"name": "Built-in Artifact Types",
"deps": []
},
{
"id": "artifact-types-config",
"name": "Artifact Types Config File",
"deps": []
}
]
}
]
},
{
"id": "runtime-data-exchange",
"title": "I need apps to exchange data safely at runtime",
"abstract": "Applications need to serialize, deserialize, fetch, and resolve schemas while data is moving. This map shows how Apicurio supports runtime schema lookup, Kafka integration, Confluent compatibility, contract enforcement, and client-side adoption paths.",
"categories": [
{
"id": "user-outcomes",
"title": "User Outcomes",
"items": [
{
"id": "safe-runtime-exchange",
"name": "Safe Runtime Data Exchange",
"deps": [
"kafka-serdes",
"schema-resolution",
"runtime-contract-enforcement"
]
},
{
"id": "drop-in-migration",
"name": "Drop-in Migration Path",
"deps": [
"confluent-compatibility",
"registry-api"
]
},
{
"id": "developer-integration",
"name": "Developer Integration",
"deps": [
"client-sdks",
"maven-plugin",
"registry-api"
]
}
]
},
{
"id": "runtime-capabilities",
"title": "Runtime Capabilities",
"items": [
{
"id": "kafka-serdes",
"name": "Kafka SerDes Integration",
"deps": [
"schema-resolution",
"kafka-clients",
"artifact-storage-versioning"
]
},
{
"id": "confluent-compatibility",
"name": "Confluent Schema Registry Compatibility",
"deps": [
"compatibility-api",
"schema-resolution"
]
},
{
"id": "runtime-contract-enforcement",
"name": "Runtime Contract Enforcement",
"deps": [
"contract-rules",
"kafka-serdes"
]
},
{
"id": "schema-resolution",
"name": "Schema Resolution",
"deps": [
"global-id",
"content-id",
"artifact-storage-versioning"
]
}
]
},
{
"id": "client-access",
"title": "Client Access",
"items": [
{
"id": "client-sdks",
"name": "Multi-Language Client SDKs",
"deps": [
"registry-api"
]
},
{
"id": "maven-plugin",
"name": "Maven Plugin",
"deps": [
"registry-api"
]
},
{
"id": "compatibility-api",
"name": "Compatibility APIs",
"deps": [
"registry-api"
]
},
{
"id": "registry-api",
"name": "Registry REST API",
"deps": [
"authn-authz",
"storage-backend"
]
}
]
},
{
"id": "governance-inputs",
"title": "Governance Inputs",
"items": [
{
"id": "contract-rules",
"name": "Contract Rules",
"deps": [
"data-contracts",
"cel-jsonata"
]
},
{
"id": "data-contracts",
"name": "Data Contracts",
"deps": [
"artifact-storage-versioning"
]
},
{
"id": "artifact-storage-versioning",
"name": "Artifact Storage & Versioning",
"deps": [
"storage-backend"
]
},
{
"id": "global-id",
"name": "Global ID",
"deps": []
},
{
"id": "content-id",
"name": "Content ID",
"deps": []
}
]
},
{
"id": "external-systems",
"title": "External Systems",
"items": [
{
"id": "kafka-clients",
"name": "Java Kafka Clients",
"deps": [
"kafka-cluster"
]
},
{
"id": "kafka-cluster",
"name": "Kafka Cluster",
"deps": []
},
{
"id": "authn-authz",
"name": "Authentication & Authorization",
"deps": [
"identity-provider"
]
},
{
"id": "identity-provider",
"name": "Identity Provider",
"deps": []
},
{
"id": "cel-jsonata",
"name": "CEL and JSONata",
"deps": []
},
{
"id": "storage-backend",
"name": "Storage Backend",
"deps": []
}
]
}
]
},
{
"id": "change-confidence",
"title": "I need to know who uses what before I change or remove it",
"abstract": "A schema can look unused until a consumer breaks. This map shows how Apicurio can track usage, classify active or stale versions, support deprecation decisions, emit change events, and help teams automate lifecycle governance.",
"categories": [
{
"id": "user-outcomes",
"title": "User Outcomes",
"items": [
{
"id": "change-confidence",
"name": "Change Confidence",
"deps": [
"usage-telemetry",
"consumer-heatmap",
"deprecation-readiness"
]
},
{
"id": "safe-retirement",
"name": "Safe Version Retirement",
"deps": [
"active-stale-dead",
"version-lifecycle-state",
"deprecation-readiness"
]
},
{
"id": "automation-triggers",
"name": "Automation Triggers",
"deps": [
"change-events",
"audit-log"
]
}
]
},
{
"id": "lifecycle-governance",
"title": "Lifecycle Governance",
"items": [
{
"id": "usage-telemetry",
"name": "Usage Telemetry",
"deps": [
"usage-events",
"client-identification",
"schema-fetch-tracking"
]
},
{
"id": "active-stale-dead",
"name": "Active / Stale / Dead Classification",
"deps": [
"usage-telemetry",
"usage-thresholds"
]
},
{
"id": "consumer-heatmap",
"name": "Consumer Version Heatmap",
"deps": [
"usage-telemetry"
]
},
{
"id": "deprecation-readiness",
"name": "Deprecation Readiness Reports",
"deps": [
"usage-telemetry",
"version-lifecycle-state"
]
},
{
"id": "version-lifecycle-state",
"name": "Version Lifecycle State",
"deps": [
"artifact-storage-versioning"
]
}
]
},
{
"id": "eventing",
"title": "Eventing & Audit",
"items": [
{
"id": "change-events",
"name": "Change Events",
"deps": [
"outbox-pattern",
"registry-mutations"
]
},
{
"id": "audit-log",
"name": "Audit Log",
"deps": [
"change-events"
]
},
{
"id": "outbox-pattern",
"name": "Outbox Pattern",
"deps": [
"sql-storage",
"debezium"
]
},
{
"id": "kafkasql-events",
"name": "KafkaSQL Event Publishing",
"deps": [
"kafkasql-storage"
]
}
]
},
{
"id": "tracking-inputs",
"title": "Tracking Inputs",
"items": [
{
"id": "usage-events",
"name": "Usage Events",
"deps": [
"schema-fetch-tracking"
]
},
{
"id": "client-identification",
"name": "Client Identification Headers",
"deps": []
},
{
"id": "schema-fetch-tracking",
"name": "Schema Fetch Tracking",
"deps": [
"registry-api"
]
},
{
"id": "usage-thresholds",
"name": "Usage Thresholds",
"deps": []
},
{
"id": "registry-mutations",
"name": "Registry Mutations",
"deps": [
"registry-api"
]
}
]
},
{
"id": "registry-foundation",
"title": "Registry Foundation",
"items": [
{
"id": "artifact-storage-versioning",
"name": "Artifact Storage & Versioning",
"deps": [
"storage-backend"
]
},
{
"id": "registry-api",
"name": "Registry REST API",
"deps": [
"storage-backend"
]
},
{
"id": "sql-storage",
"name": "SQL Storage",
"deps": [
"database"
]
},
{
"id": "kafkasql-storage",
"name": "KafkaSQL Storage",
"deps": [
"kafka-cluster"
]
},
{
"id": "storage-backend",
"name": "Storage Backend",
"deps": []
},
{
"id": "debezium",
"name": "Debezium CDC",
"deps": [
"database"
]
},
{
"id": "database",
"name": "Database",
"deps": []
}
]
},
{
"id": "external-systems",
"title": "External Systems",
"items": [
{
"id": "kafka-cluster",
"name": "Kafka Cluster",
"deps": []
}
]
}
]
},
{
"id": "contract-meaning",
"title": "I need schemas to carry ownership, quality, and compliance meaning",
"abstract": "A schema describes structure, but teams also need to know who owns it, whether it contains sensitive fields, what quality rules apply, and whether it is ready for production. This map shows how data contracts add business and governance context to technical definitions.",
"categories": [
{
"id": "user-outcomes",
"title": "User Outcomes",
"items": [
{
"id": "trusted-data-products",
"name": "Trusted Data Products",
"deps": [
"data-contracts",
"quality-rules",
"ownership-metadata"
]
},
{
"id": "compliance-awareness",
"name": "Compliance Awareness",
"deps": [
"field-tags",
"classification-tags",
"contract-search"
]
},
{
"id": "production-readiness",
"name": "Production Readiness",
"deps": [
"contract-lifecycle",
"promotion-stages",
"quality-scoring"
]
}
]
},
{
"id": "contract-capabilities",
"title": "Contract Capabilities",
"items": [
{
"id": "data-contracts",
"name": "Data Contracts",
"deps": [
"odcs-format",
"artifact-storage-versioning"
]
},
{
"id": "ownership-metadata",
"name": "Ownership Metadata",
"deps": [
"contract-metadata"
]
},
{
"id": "quality-rules",
"name": "Quality Rules",
"deps": [
"contract-rules",
"cel-jsonata"
]
},
{
"id": "field-tags",
"name": "Field-Level Tags",
"deps": [
"schema-field-extraction",
"version-labels"
]
},
{
"id": "multi-contract-support",
"name": "Multi-Contract Support",
"deps": [
"data-contracts",
"artifact-storage-versioning"
]
}
]
},
{
"id": "lifecycle-and-search",
"title": "Lifecycle & Search",
"items": [
{
"id": "contract-lifecycle",
"name": "Contract Lifecycle",
"deps": [
"contract-status",
"promotion-stages"
]
},
{
"id": "promotion-stages",
"name": "Promotion Stages",
"deps": [
"contract-status"
]
},
{
"id": "quality-scoring",
"name": "Quality Scoring",
"deps": [
"quality-rules"
]
},
{
"id": "contract-search",
"name": "Contract Search",
"deps": [
"contract-metadata",
"search-discovery"
]
},
{
"id": "classification-tags",
"name": "PII and Classification Tags",
"deps": [
"field-tags"
]
}
]
},
{
"id": "rule-and-label-foundation",
"title": "Rule & Label Foundation",
"items": [
{
"id": "contract-rules",
"name": "Contract Rules",
"deps": [
"rules-engine"
]
},
{
"id": "contract-metadata",
"name": "Contract Metadata",
"deps": [
"artifact-labels"
]
},
{
"id": "version-labels",
"name": "Version Labels",
"deps": [
"artifact-storage-versioning"
]
},
{
"id": "schema-field-extraction",
"name": "Schema Field Extraction",
"deps": [
"multi-format-support"
]
},
{
"id": "contract-status",
"name": "Contract Status",
"deps": []
}
]
},
{
"id": "registry-foundation",
"title": "Registry Foundation",
"items": [
{
"id": "artifact-storage-versioning",
"name": "Artifact Storage & Versioning",
"deps": [
"storage-backend"
]
},
{
"id": "multi-format-support",
"name": "Multi-Format Support",
"deps": [
"artifact-types"
]
},
{
"id": "rules-engine",
"name": "Rules Engine",
"deps": [
"storage-backend"
]
},
{
"id": "artifact-labels",
"name": "Artifact Labels",
"deps": [
"storage-backend"
]
},
{
"id": "search-discovery",
"name": "Search & Discovery",
"deps": [
"storage-backend"
]
},
{
"id": "odcs-format",
"name": "ODCS Format",
"deps": []
},
{
"id": "cel-jsonata",
"name": "CEL and JSONata",
"deps": []
}
]
},
{
"id": "infrastructure",
"title": "Infrastructure",
"items": [
{
"id": "artifact-types",
"name": "Schema Formats",
"deps": []
},
{
"id": "storage-backend",
"name": "Storage Backend",
"deps": []
}
]
}
]
},
{
"id": "platform-fit",
"title": "I need this to fit how my platform already works",
"abstract": "Platform teams do not want a special-purpose tool that sits outside their operating model. This map shows how Apicurio can be deployed, secured, observed, automated, and adapted to existing Kubernetes, GitOps, Kafka, database, search, and identity infrastructure.",
"categories": [
{
"id": "user-outcomes",
"title": "User Outcomes",
"items": [
{
"id": "platform-fit",
"name": "Platform Fit",
"deps": [
"kubernetes-operator",
"storage-backends",
"authn-authz"
]
},
{
"id": "operational-control",
"name": "Operational Control",
"deps": [
"opentelemetry-observability",
"change-events",
"cli"
]
},
{
"id": "team-isolation",
"name": "Team Isolation",
"deps": [
"multitenancy",
"authn-authz",
"network-isolation"
]
}
]
},
{
"id": "deployment-models",
"title": "Deployment Models",
"items": [
{
"id": "kubernetes-operator",
"name": "Kubernetes Operator",
"deps": [
"kubernetes-cluster",
"registry-custom-resource"
]
},
{
"id": "multitenancy",
"name": "Multitenancy",
"deps": [
"kubernetes-operator",
"tenant-custom-resources"
]
},
{
"id": "gitops-storage",
"name": "GitOps Storage",
"deps": [
"git-repository",
"sidecar-sync"
]
},
{
"id": "kubernetesops-storage",
"name": "KubernetesOps Storage",
"deps": [
"configmaps",
"kubernetes-api"
]
},
{
"id": "cli",
"name": "CLI",
"deps": [
"registry-api"
]
}
]
},
{
"id": "security-and-observability",
"title": "Security & Observability",
"items": [
{
"id": "authn-authz",
"name": "Authentication & Authorization",
"deps": [
"identity-provider",
"rbac-obac"
]
},
{
"id": "opentelemetry-observability",
"name": "OpenTelemetry Observability",
"deps": [
"otel-collector"
]
},
{
"id": "change-events",
"name": "Change Events",
"deps": [
"outbox-pattern",
"kafkasql-events"
]
},
{
"id": "search-indexing",
"name": "Elasticsearch Search Indexing",
"deps": [
"elasticsearch"
]
},
{
"id": "network-isolation",
"name": "Network Isolation",
"deps": [
"kubernetes-network-policy"
]
}
]
},
{
"id": "storage-and-runtime",
"title": "Storage & Runtime",
"items": [
{
"id": "storage-backends",
"name": "Multiple Storage Backends",
"deps": [
"sql-storage",
"kafkasql-storage",
"in-memory-storage",
"gitops-storage"
]
},
{
"id": "sql-storage",
"name": "SQL Storage",
"deps": [
"database"
]
},
{
"id": "kafkasql-storage",
"name": "KafkaSQL Storage",
"deps": [
"kafka-cluster"
]
},
{
"id": "in-memory-storage",
"name": "In-Memory Storage",
"deps": []
},
{
"id": "registry-api",
"name": "Registry REST API",
"deps": [
"storage-backends"
]
}
]
},
{
"id": "platform-primitives",
"title": "Platform Primitives",
"items": [
{
"id": "registry-custom-resource",
"name": "Registry Custom Resource",
"deps": [
"kubernetes-api"
]
},
{
"id": "tenant-custom-resources",
"name": "Tenant Custom Resources",
"deps": [
"registry-custom-resource"
]
},
{
"id": "outbox-pattern",
"name": "Outbox Pattern",
"deps": [
"database"
]
},
{
"id": "kafkasql-events",
"name": "KafkaSQL Events Topic",
"deps": [
"kafka-cluster"
]
},
{
"id": "rbac-obac",
"name": "RBAC and OBAC",
"deps": []
},
{
"id": "sidecar-sync",
"name": "Sidecar Sync",
"deps": [
"git-repository"
]
}
]
},
{
"id": "external-infrastructure",
"title": "External Infrastructure",
"items": [
{
"id": "kubernetes-cluster",
"name": "Kubernetes or OpenShift",
"deps": []
},
{
"id": "kubernetes-api",
"name": "Kubernetes API",
"deps": [
"kubernetes-cluster"
]
},
{
"id": "kubernetes-network-policy",
"name": "Kubernetes NetworkPolicy",
"deps": [
"kubernetes-cluster"
]
},
{
"id": "configmaps",
"name": "ConfigMaps",
"deps": [
"kubernetes-api"
]
},
{
"id": "database",
"name": "Database",
"deps": []
},
{
"id": "kafka-cluster",
"name": "Kafka Cluster",
"deps": []
},
{
"id": "git-repository",
"name": "Git Repository",
"deps": []
},
{
"id": "identity-provider",
"name": "Identity Provider",
"deps": []
},
{
"id": "otel-collector",
"name": "OpenTelemetry Collector",
"deps": []
},
{
"id": "elasticsearch",
"name": "Elasticsearch",
"deps": []
}
]
}
]
},
{
"id": "data-tooling-bridge",
"title": "I need schemas to work inside my data and AI tooling",
"abstract": "Some users meet Apicurio through the tools they already use for streaming, analytics, lakehouse tables, search, or AI agents. This map shows how registry content can surface through Flink, Iceberg, Kafka, custom artifact types, AI/MCP, and richer discovery paths.",
"categories": [
{
"id": "user-outcomes",
"title": "User Outcomes",
"items": [
{
"id": "tool-native-discovery",
"name": "Tool-Native Discovery",
"deps": [
"flink-catalog",
"iceberg-rest-catalog",
"search-discovery"
]
},
{
"id": "streaming-table-alignment",
"name": "Streaming and Table Alignment",
"deps": [
"kafka-serdes",
"flink-catalog",
"iceberg-rest-catalog"
]
},
{
"id": "ai-ready-contracts",
"name": "AI-Ready Contracts",
"deps": [
"ai-mcp-integration",
"custom-artifact-types",
"data-contracts"
]
}
]
},
{
"id": "data-tool-integrations",
"title": "Data Tool Integrations",
"items": [
{
"id": "flink-catalog",
"name": "Apache Flink Catalog",
"deps": [
"flink-runtime",
"schema-conversion",
"artifact-storage-versioning"
]
},
{
"id": "iceberg-rest-catalog",
"name": "Iceberg REST Catalog",
"deps": [
"iceberg-rest-api",
"query-engines",
"artifact-storage-versioning"
]
},
{
"id": "kafka-serdes",
"name": "Kafka SerDes Integration",
"deps": [
"kafka-cluster",
"artifact-storage-versioning"
]
},
{
"id": "search-discovery",
"name": "Search & Discovery",
"deps": [
"metadata-search",
"search-indexing"
]
}
]
},
{
"id": "ai-and-extension",
"title": "AI & Extension",
"items": [
{
"id": "ai-mcp-integration",
"name": "AI / MCP Integration",
"deps": [
"agent-cards",
"prompt-templates",
"model-schemas",
"mcp-tools"
]
},
{
"id": "custom-artifact-types",
"name": "Custom Artifact Types",
"deps": [
"artifact-types-config"
]
},
{
"id": "data-contracts",
"name": "Data Contracts",
"deps": [
"odcs-format",
"artifact-storage-versioning"
]
}
]
},
{
"id": "registry-capabilities",
"title": "Registry Capabilities",
"items": [
{
"id": "artifact-storage-versioning",
"name": "Artifact Storage & Versioning",
"deps": [
"storage-backend"
]
},
{
"id": "schema-conversion",
"name": "Schema Conversion",
"deps": [
"multi-format-support"
]
},
{
"id": "multi-format-support",
"name": "Multi-Format Support",
"deps": [
"built-in-artifact-types"
]
},
{
"id": "metadata-search",
"name": "Metadata Search",
"deps": [
"storage-backend"
]
},
{
"id": "search-indexing",
"name": "Elasticsearch Content Indexing",
"deps": [
"elasticsearch"
]
},
{
"id": "iceberg-rest-api",
"name": "Iceberg REST API",
"deps": [
"registry-api"
]
},
{
"id": "registry-api",
"name": "Registry REST API",
"deps": [
"storage-backend"
]
}
]
},
{
"id": "artifact-families",
"title": "Artifact Families",
"items": [
{
"id": "built-in-artifact-types",
"name": "Built-in Artifact Types",
"deps": []
},
{
"id": "agent-cards",
"name": "Agent Cards",
"deps": [
"custom-artifact-types"
]
},
{
"id": "prompt-templates",
"name": "Prompt Templates",
"deps": [
"custom-artifact-types"
]
},
{
"id": "model-schemas",
"name": "Model Schemas",
"deps": [
"custom-artifact-types"
]
},
{
"id": "mcp-tools",
"name": "MCP Tools",
"deps": [
"custom-artifact-types"
]
},
{
"id": "artifact-types-config",
"name": "Artifact Types Config File",
"deps": []
},
{
"id": "odcs-format",
"name": "ODCS Format",
"deps": []
}
]
},
{
"id": "external-systems",
"title": "External Systems",
"items": [
{
"id": "flink-runtime",
"name": "Apache Flink",
"deps": []
},
{
"id": "query-engines",
"name": "Query Engines",
"deps": []
},
{
"id": "kafka-cluster",
"name": "Kafka Cluster",
"deps": []
},
{
"id": "elasticsearch",
"name": "Elasticsearch",
"deps": []
},
{
"id": "storage-backend",
"name": "Storage Backend",
"deps": []
}
]
}
]
}
]
```
