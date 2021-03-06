# Build the application first using Maven
FROM maven:3.8.4-openjdk-17 as build
WORKDIR /app
COPY . .
RUN mvn install

# Inject the JAR file into a new container to keep the file small
FROM openjdk:17-oracle
WORKDIR /app
COPY --from=build /app/target/hello-java-spring-boot-*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar"]
