## Kafka producer-consumer in docker with CentOS [indexer]

# Introduction

### **Kafka Producer will sent messages to Kafka topic, and Kafka Consumer will post this messages to console.**


# How to use ? 


1. git clone https://github.com/wurstmeister/kafka-docker.git
2. Add docker-compose.yml to kafka-docker
```yaml
version: '3.5'
services:
  zookeeper:
    image: zookeeper:3.4.9
    ports:
      - 2181:2181
    networks:
      - ta-net

  kafka:
    image: wurstmeister/kafka:2.12-2.1.1
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ADVERTISED_HOST_NAME: kafka
      KAFKA_ADVERTISED_PORT: 9092
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_LISTENERS: INTERNAL://kafka:9092,OUTSIDE://kafka:9094
      KAFKA_ADVERTISED_LISTENERS: INTERNAL://kafka:9092,OUTSIDE://localhost:9094
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INTERNAL:PLAINTEXT,OUTSIDE:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: INTERNAL
      KAFKA_CREATE_TOPICS: "art_test_topic:1:1"
    depends_on:
      - zookeeper
    ports:
      - 9092:9092
    networks:
      - ta-net

networks:
  ta-net:
```
3. Start the cluster
```
    docker-compose up -d
   ```
   
4. `mvn clean install`

5. `docker build -t java-application .`
6. `docker run --network kafka-docker_ta-net java-application`
7. change mainClass in pom.xml to ConsumerDemo if you want to run kafka consumer (steps 4-6)
