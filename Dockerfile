FROM adoptopenjdk/openjdk11
COPY target/achat-1.0-SNAPSHOT.jar achat-1.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/achat-1.0-SNAPSHOT.jar"]
