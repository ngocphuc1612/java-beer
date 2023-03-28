# Build stage
FROM maven:3.8-openjdk-17-slim AS build
WORKDIR /home/app
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

# Package stage
FROM openjdk:17-jdk-slim
WORKDIR /home/app
COPY --from=build /home/app/target/*.jar /home/app/app.jar
# EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]