FROM openjdk:11-jre-slim
ARG jar_file=target/*.jar
COPY ${jar_file} /app.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]