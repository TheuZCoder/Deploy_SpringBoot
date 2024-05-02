FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y openjdk-17-jdk

COPY . .

RUN apt-get install maven -y

RUN mvn cleans install

FROM openjdk-17-jdk-slim

EXPOSE 8080

COPY --from=build /target/gamestore.jar /app.jar

ENTRYPOINT ["java","-jar","app.jar"]