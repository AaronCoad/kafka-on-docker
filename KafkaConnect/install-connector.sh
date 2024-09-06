echo "Installing Kafka Confluent Connector"
confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.0.0
/etc/confluent/docker/run
sleep infinity