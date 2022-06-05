#
# Build
#
FROM maven:3.5.2-jdk-8-alpine AS build
 
LABEL maintainer="Dibya Darshan Khanal"
 
WORKDIR /home/app
 
COPY . /home/app
 
RUN mvn clean package -DskipTests
 
 # here add path only to /home/app
 
COPY .env /home/app/target
 
#
# Package stage
#
FROM openjdk:8-jdk-slim


COPY --from=build /home/app/target/* /usr/local/lib/

COPY .env usr/local/lib

COPY .env /

EXPOSE 8080

ENTRYPOINT ["java","-jar","/usr/local/lib/ontarget.jar"]
