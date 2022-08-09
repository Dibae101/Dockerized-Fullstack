# Build
#

FROM maven:3.5.2-jdk-8-alpine AS build

LABEL maintainer="Dibya Darshan Khanal"

ENV HOME=/usr/app

RUN mkdir -p $HOME

WORKDIR $HOME

ADD . $HOME

# RUN export DOCKER_BUILDKIT=1

RUN export COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1

RUN --mount=type=cache,target=/root/.m2 mvn -f $HOME/pom.xml clean package -DskipTests

# here add path only to /home/app
#
# Package stage
#
FROM openjdk:8-jdk-slim

RUN apt-get update && apt-get install -y fontconfig libfreetype6 

COPY --from=build /usr/app/target/* /usr/local/lib/

COPY .env.example /usr/local/lib/.env

COPY .env.example /.env

EXPOSE 8080

ENTRYPOINT ["java","-jar","/usr/local/lib/ontarget.jar"]


# DOCKER_BUILDKIT=1 docker build -t new-backend -f backend.dockerfile .

# docker run -dp 8080:8080 new-backend

# SOlving maven wrapper issue:
# RUN mvn -N io.takari:maven:wrapper
# export DOCKER_BUILDKIT=1
