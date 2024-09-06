echo "Waiting for Kafka Connect to start listening on kafkaconnect:8083 ⏳"
while : ; do
  curl_status=$(curl -s -o /dev/null -w %{http_code} http://kafkaconnect:8083/connectors)
  echo -e $(date) " Kafka Connect listener HTTP state: " $curl_status " (waiting for 200)"
  if [ $curl_status -eq 200 ] ; then
  break
  fi
  sleep 5
done
curl_status=$(curl -s -o /dev/null -w %{http_code} http://kafkaconnect:8083/connectors/mssql-jdbc-product-00)
if [ $curl_status -eq 404 ] ; then
curl --location --request POST http://kafkaconnect:8083/connectors/  \
    --header 'Content-Type: application/json' --header 'Accept: application/json' \
    -d @- <<EOF
{
  "name": "mssql-jdbc-product-00",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "connection.url": "jdbc:sqlserver://;servername=sql1;encrypt=false;databaseName=DemoData;",
    "connection.user" : "sa",
    "connection.password": "alphab3t@",
    "numeric.mapping" : "best_fit",
    "tasks.max": "1",
    "mode": "timestamp+incrementing",
    "timestamp.column.name": "LastModified",
    "incrementing.column.name": "Id",
    "catalog.pattern":"DemoData",
    "schema.pattern":"dbo",
    "table.whitelist": "Product",
    "table.types": "TABLE",
    "topics": "product",
    "topic.prefix":"demo.",
    "validate.non.null": "false",
    "poll.interval.ms": "1000",
    "batch.max.rows": "3000",
    "table.poll.interval.ms": "6000",
    "topic.creation.default.replication.factor":"1",
    "topic.creation.default.partitions":"1",
    "group.id":"product-connector"
    }
}
EOF
fi
#
curl_status=$(curl -s -o /dev/null -w %{http_code} http://kafkaconnect:8083/connectors/mssql-jdbc-people-00)
if [ $curl_status -eq 404 ] ; then
curl --location --request POST http://kafkaconnect:8083/connectors/  \
    --header 'Content-Type: application/json' --header 'Accept: application/json' \
    -d @- <<EOF
{
  "name": "mssql-jdbc-people-00",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "connection.url": "jdbc:sqlserver://;servername=sql1;encrypt=false;databaseName=DemoData;",
    "connection.user" : "sa",
    "connection.password": "alphab3t@",
    "numeric.mapping" : "best_fit",
    "tasks.max": "1",
    "mode": "timestamp+incrementing",
    "timestamp.column.name": "LastModified",
    "incrementing.column.name": "PersonId",
    "catalog.pattern":"DemoData",
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