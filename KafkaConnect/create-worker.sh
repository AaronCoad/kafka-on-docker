echo "Installing Kafka Confluent Connector"
confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.0.0
/etc/confluent/docker/run &
#
echo "Waiting for Kafka Connect to start listening on 0.0.0.0:8083 ⏳"
while : ; do
  curl_status=$(curl -s -o /dev/null -w %{http_code} http://0.0.0.0:8083/connectors)
  echo -e $(date) " Kafka Connect listener HTTP state: " $curl_status " (waiting for 200)"
  if [ $curl_status -eq 200 ] ; then
  break
  fi
  sleep 5
done
curl --location --request POST http://localhost:8083/connectors/  \
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
    "timestamp.initial": "-1",
    "topics": "product",
    "topic.prefix":"demo.",
    "validate.non.null": "false",
    "poll.interval.ms": "1000",
    "batch.max.rows": "3000",
    "table.poll.interval.ms": "6000",
    "topic.creation.default.replication.factor":"1",
    "topic.creation.default.partitions":"1"
    }
}
EOF
sleep infinity