FROM adoptopenjdk/openjdk11
COPY target/achat-6.0.jar achat-6.0.jar
ENTRYPOINT ["java","-jar","/achat-6.0.jar"]
