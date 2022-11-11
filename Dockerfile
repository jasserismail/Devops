FROM adoptopenjdk/openjdk11
COPY target/achat-2.0-SNAPSHOT.jar achat-2.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/achat-2.0-SNAPSHOT.jar"]
