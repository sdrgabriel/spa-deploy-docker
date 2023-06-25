# FROM --platform=linux/amd64 openjdk:17-jdk-slim

# ARG JAR_FILE=target/*.jar
# COPY ${JAR_FILE} app.jar

# RUN bash -c 'touch /app.jar'

# ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/ ./unrandom", "-jar", "/app.jar"]

FROM --platform=linux/amd64 openjdk:17-jdk-slim

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y wget unzip

RUN wget -q --show-progress --progress=bar:force:noscroll https://services.gradle.org/distributions/gradle-7.1.1-bin.zip \
    && unzip gradle-7.1.1-bin.zip \
    && rm gradle-7.1.1-bin.zip \
    && export PATH=$PATH:/app/gradle-7.1.1/bin \
    && ./gradlew build

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./unrandom", "-jar", "/app/build/libs/your-jar-file.jar"]
