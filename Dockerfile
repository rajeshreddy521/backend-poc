FROM openjdk:11-jdk-slim AS build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests

FROM openjdk:11-jre-slim
VOLUME /tmp
ARG DEPENDENCY=/workspace/app/target
COPY --from=build ${DEPENDENCY}/backend-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
