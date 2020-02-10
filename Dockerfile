FROM centos

RUN yum install -y \
       java-1.8.0-openjdk \
       java-1.8.0-openjdk-devel

ENV JAVA_HOME /etc/alternatives/jre

ADD /target/kafka-producer-docker-1.0-SNAPSHOT-jar-with-dependencies.jar demo.jar
ENTRYPOINT ["java","-jar","demo.jar"]

