FROM ubuntu:latest

WORKDIR /app

COPY index.html /app

EXPOSE 80

ENTRYPOINT [ "/app/index.html" ]