# EDUCATIONAL

## Purpose

This repository is for educational purposes only and contains the process for configuring a single cluster Kafka on Docker deployment.
This contains Kafka, Kafka UI, Kafka Schema Registry, Kafka Connect and Microsoft SQL Server containers.
The Kafka containers are connected via a Kafka bridge network and the Kafka Connect container is the only one capable of connecting to the MSSQL container.

## Deployment
This package can be deployed in a Docker Desktop environment by using docker-compose up -d
It is recommended that the SqlStartup/run-initialization.sh script is updated to support a different sleep time depending upon the performance of the host machine. Otherwise it may attempt to create the database before Sql Server is up and running.