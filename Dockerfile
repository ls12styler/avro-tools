ARG AVRO_VERSION=1.9.2

FROM alpine:latest as builder
ARG AVRO_VERSION

RUN apk add -U curl && \
    curl http://archive.apache.org/dist/avro/avro-$AVRO_VERSION/java/avro-tools-$AVRO_VERSION.jar -o /tmp/avro-tools-$AVRO_VERSION.jar

FROM openjdk:alpine
ARG AVRO_VERSION

COPY --from=builder /tmp/avro-tools-$AVRO_VERSION.jar /tmp/avro-tools.jar

ENTRYPOINT ["java", "-jar", "/tmp/avro-tools.jar"]
