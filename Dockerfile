#FROM maven:3.6.3-jdk-8-slim AS build
FROM maven:3.8.6-openjdk-11 AS build

WORKDIR /app
COPY . .
#COPY src .
COPY pom.xml .

RUN mvn clean install -DskipTests

# Package stage
#FROM openjdk:8-jdk-alpine
FROM openjdk:11.0-jdk-slim
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
