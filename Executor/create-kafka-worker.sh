#!/bin/bash
echo "Waiting for Kafka Connect to start listening on $KAFKA_CONNECT_ENDPOINT ⏳"
while : ; do
  curl_status=$(curl -s -o /dev/null -w %{http_code} http://$KAFKA_CONNECT_ENDPOINT/connectors)
  echo -e $(date) " Kafka Connect listener HTTP state: " $curl_status " (waiting for 200)"
  if [ $curl_status -eq 200 ] ; then
  break
  fi
  sleep 5
done
# curl_status=$(curl -s -o /dev/null -w %{http_code} http://$KAFKA_CONNECT_ENDPOINT/connectors/mssql-jdbc-product-00)
# if [ $curl_status -eq 404 ] ; then
# curl --location --request POST http://$KAFKA_CONNECT_ENDPOINT/connectors/  \
#     --header 'Content-Type: application/json' --header 'Accept: application/json' \
#     -d @- <<EOF
# {
#   "name": "mssql-jdbc-product-00",
#   "config": {
#     "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
#     "connection.url": "jdbc:sqlserver://;servername=$SQL_SERVER;encrypt=false;databaseName=$DATABASE;",
#     "connection.user" : "$SQL_USERNAME",
#     "connection.password": "$SQL_PASSWORD",
#     "numeric.mapping" : "best_fit",
#     "tasks.max": "1",
#     "mode": "timestamp+incrementing",
#     "timestamp.column.name": "LastModified",
#     "incrementing.column.name": "Id",
#     "catalog.pattern":"$DATABASE",
#     "schema.pattern":"dbo",
#     "table.whitelist": "Product",
#     "table.types": "TABLE",
#     "topics": "product",
#     "topic.prefix":"demo.",
#     "validate.non.null": "false",
#     "poll.interval.ms": "1000",
#     "batch.max.rows": "3000",
#     "table.poll.interval.ms": "6000",
#     "topic.creation.default.replication.factor":"1",
#     "topic.creation.default.partitions":"1",
#     "group.id":"product-connector"
#     }
# }
# EOF
# fi
#
curl_status=$(curl -s -o /dev/null -w %{http_code} http://$KAFKA_CONNECT_ENDPOINT/connectors/mssql-jdbc-people-00)
if [ $curl_status -eq 404 ] ; then
curl --location --request POST http://$KAFKA_CONNECT_ENDPOINT/connectors/  \
    --header 'Content-Type: application/json' --header 'Accept: application/json' \
    -d @- <<EOF
{
  "name": "mssql-jdbc-people-00",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "connection.url": "jdbc:sqlserver://;servername=$SQL_SERVER;encrypt=false;databaseName=$DATABASE;",
    "connection.user" : "$SQL_USERNAME",
    "connection.password": "$SQL_PASSWORD",
    "numeric.mapping" : "best_fit",
    "tasks.max": "1",
    "mode": "timestamp+incrementing",
    "timestamp.column.name": "LastModified",
    "incrementing.column.name": "PersonId",
    "catalog.pattern":"$DATABASE",
    "schema.pattern":"dbo",
    "table.whitelist": "People",
    "table.types": "TABLE",
    "topics": "People",
    "topic.prefix":"demo.",
    "validate.non.null": "false",
    "poll.interval.ms": "1000",
    "batch.max.rows": "3000",
    "table.poll.interval.ms": "6000",
    "topic.creation.default.replication.factor":"1",
    "topic.creation.default.partitions":"4",
    "group.id":"people-connector"
    }
}
EOF
fi