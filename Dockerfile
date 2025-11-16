FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN ./mvnw -v || true
# Build step is expected to be done by mvn in CI / locally; keeping Dockerfile minimal for scaffold.
EXPOSE 8080
CMD ["bash","-c","mvn -q -DskipTests package && java -jar target/*.jar"]
