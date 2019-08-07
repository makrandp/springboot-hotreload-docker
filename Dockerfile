#Base Image
FROM openjdk:8-jdk-alpine

ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/root"

RUN apk add --no-cache curl tar bash supervisor

RUN mkdir -p /usr/share/maven && \
  curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1 && \
  ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
# speed up Maven JVM a bit
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"

COPY ./ /app

WORKDIR /app

#ADD target/hotreload-app.jar hotreload-app.jar

RUN mvn clean install -Dmaven.test.skip=true

EXPOSE 8080

#Running application as a service using supervisord
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/app/config/supervisord.conf"]