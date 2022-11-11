FROM adoptopenjdk/openjdk11
COPY target/achat-6.0-SNAPSHOT.jar achat-6.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/achat-6.0-SNAPSHOT.jar"]
