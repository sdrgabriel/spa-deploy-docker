# FROM --platform=linux/amd64 openjdk:17-jdk-slim

# ARG JAR_FILE=target/*.jar
# COPY ${JAR_FILE} app.jar

# RUN bash -c 'touch /app.jar'

# ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/ ./unrandom", "-jar", "/app.jar"]

FROM --platform=linux/amd64 openjdk:17-jdk-slim

WORKDIR /app

COPY . /app

RUN ./gradlew build

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./unrandom", "-jar", "/app/build/libs/your-jar-file.jar"]
