# Build stage
FROM maven:3.6.0-jdk-11-slim AS build
COPY "src" "app/src"
COPY "pom.xml" "app/"
RUN --mount=type=cache,target=/root/.m2 mvn -f "app/pom.xml" clean package

# Package stage
FROM openjdk:11-jre-slim
COPY --from=build "app/target/configserver*.jar" "config-server.jar"
EXPOSE 8090
ENTRYPOINT ["java","-jar","-DskipTests","config-server.jar"]