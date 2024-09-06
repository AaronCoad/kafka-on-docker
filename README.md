# EDUCATIONAL

## Purpose
This repository is for educational purposes only and contains the process for configuring a single cluster Kafka on Docker deployment.

## Deployment
This package can be deployed in a Docker Desktop environment by using docker-compose up -d \
To avoid an attempt to create the database before SQL Server is initialised the [SqlStartup/run-initialization.sh](./SqlStartup/run-initialization.sh) script may need the initial sleep adjusted. \
[SqlStartup/create-database.sql](./SqlStartup/create-database.sql) can be modified to your needs. \
\
KafkaConnect installs the relevant JDBC connector while Executor sends the request to create the workers.

## Components
- Containers
  - Kafka Broker (single cluster)
  - Kafka Schema Registry
  - Kafka UI
  - Kafka Connect
  - Microsoft SQL Server
- Networks
  - Kafka Bridge Network
  - SQL Server Bridge Network

## Interactions
Kafka Connect uses both the Kafka Bridge Network and SQL Server Bridge Network. \
Kafka Schema Registry is externally available on http://localhost:8085 \
Kafka Broker is externally available on localhost:9092 \
Kafka UI is externally available on http://localhost:8080 \
Microsoft SQL Server is externally available via SSMS at localhost

## References
https://github.com/tometchy/Mssql-docker-initialization-demo/blob/master/Dockerfile \
https://github.com/provectus/kafka-ui/blob/master/documentation/compose/kafka-ui.yaml \
https://medium.com/cstech/streaming-data-from-mysql-with-kafka-connect-jdbc-source-connector-428f4db20b5b \
https://docs.confluent.io/platform/current/connect/references/restapi.html \
https://docs.confluent.io/platform/current/connect/userguide.html \
https://docs.confluent.io/kafka-connectors/jdbc/current/source-connector/source_config_options.html