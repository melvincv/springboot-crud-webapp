# Multi Stage Dockerfile
# Stage 1: Build App
FROM openjdk:11-jdk-slim as build
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
# maven install
		maven; \
	rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy App
COPY pom.xml .
COPY src src

# Build a jar file
RUN mvn package -DskipTests

# Stage 2: Build final image
# First copy to the repo root and modify application.properties
FROM openjdk:11-jre-slim
ARG jar_file=/app/target/*.jar
COPY --from=build ${jar_file} /app.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]