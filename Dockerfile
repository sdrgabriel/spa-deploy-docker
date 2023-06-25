# FROM --platform=linux/amd64 openjdk:17-jdk-slim

# ARG JAR_FILE=target/*.jar
# COPY ${JAR_FILE} app.jar

# RUN bash -c 'touch /app.jar'

# ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/ ./unrandom", "-jar", "/app.jar"]

FROM --platform=linux/amd64 openjdk:17-jdk-slim

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y curl

RUN curl -sL https://services.gradle.org/distributions/gradle-7.1.1-bin.zip -o gradle.zip \
    && unzip gradle.zip \
    && rm gradle.zip \
    && export PATH=$PATH:/app/gradle-7.1.1/bin \
    && ./gradlew build

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./unrandom", "-jar", "/app/build/libs/your-jar-file.jar"]
