---
type: Concept
title: Kafka SerDes integration
id: apicurio-concept-kafka-serdes
status: generated
reviewed: false
source_repo: https://github.com/Apicurio/apicurio-registry.git
source_branch: main
source_commit: ff554ec5111d2636d3d171361f344b6fdefdc579
source_paths:
  - human/apicurio-registry/docs/modules/ROOT/pages/getting-started/assembly-using-kafka-client-serdes.adoc
tags:
  - apicurio
  - concept
  - kafka
  - serdes
related:
  - apicurio-concept-schema-resolution
  - apicurio-concept-confluent-compatibility
  - apicurio-concept-data-contracts
---

# Kafka SerDes integration

Apicurio Registry provides Java Kafka serializers and deserializers that let producers and consumers use schemas stored in the registry at runtime.

Producer applications configure:

- the registry URL,
- a serializer,
- a strategy that maps a topic/message to an artifact reference,
- and a schema resolver strategy that looks up or registers schema versions.

Consumer applications configure:

- the registry URL,
- a deserializer,
- and the expected input stream format.

The default serializer lookup strategy is `TopicIdStrategy`, which maps messages to artifacts named after the topic and key/value role. Alternative strategies support record-based and topic-record-based naming.

This is the runtime-data-exchange path in the map: registry definitions become active in the message flow, not just documentation stored out of band.

