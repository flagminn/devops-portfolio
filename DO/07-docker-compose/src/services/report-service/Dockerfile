FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /app
RUN apk add --no-cache bash dos2unix

COPY mvnw pom.xml ./
COPY .mvn/ ./.mvn/

RUN dos2unix mvnw && chmod +x mvnw


RUN ./mvnw dependency:go-offline

COPY src ./src

RUN ./mvnw package -DskipTests

FROM eclipse-temurin:21-jre-alpine

WORKDIR /app
RUN apk add --no-cache bash dos2unix

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --chown=appuser:appgroup wait-for-it.sh ./wait-for-it.sh
RUN dos2unix wait-for-it.sh && chmod +x wait-for-it.sh
USER appuser

COPY --from=builder --chown=appuser:appgroup /app/target/*.jar app.jar

ENTRYPOINT ["/bin/bash", "-c", "./wait-for-it.sh db:5432 --strict -- ./wait-for-it.sh rabbitmq:5672 --strict -- java -jar app.jar"]
