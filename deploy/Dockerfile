FROM openjdk:21-jdk-slim
WORKDIR /app

ARG APP_VERSION='0.0.1-SNAPSHOT'
ENV SERVER_PORT 6060

COPY /app/build/libs/TestMicroservice-${APP_VERSION}.jar /app/appication.jar

EXPOSE ${SERVER_PORT}
ENTRYPOINT ["java", "-jar", "/app/appication.jar"]
