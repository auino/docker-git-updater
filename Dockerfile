FROM ubuntu:20.04
MAINTAINER Enrico Cambiaso <enrico.cambiaso@gmail.com>

COPY . /app
WORKDIR /app

RUN apt-get update

RUN apt-get install -y openssh-client
RUN apt-get install -y git

CMD [ "bash", "/app/run.sh" ]
