# EDUCATIONAL

## Purpose
This repository is for educational purposes only and contains the process for configuring a single cluster Kafka on Docker deployment.

## Deployment
This package can be deployed in a Docker Desktop environment by using docker-compose up -d
To avoid an attempt to create the database before SQL Server is initialised the SqlStartup/run-initialization.sh script may need the initial sleep adjusted.

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
Kafka Connect uses both the Kafka Bridge Network and SQL Server Bridge Network.
Kafka Schema Registry is externally available on http://localhost:8085
Kafka Broker is externally available on localhost:9092
Kafka UI is externally available on http://localhost:8080
Microsoft SQL Server is externally available via SSMS at localhost