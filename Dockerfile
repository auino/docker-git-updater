FROM ubuntu:20.04
MAINTAINER Enrico Cambiaso <enrico.cambiaso@gmail.com>

ENV GIT_REPOSITORY=""
ENV GIT_BRANCH="master"
ENV GIT_ORIGIN="origin"
ENV GIT_EMAIL="git@example.com"
ENV GIT_USERNAME="me"
ENV GIT_PASSWORD="mystrongpassword"
#ENV FILES_TO_COMMIT="."
ENV FILES_TO_COMMIT="file1,file2"

COPY . /app
WORKDIR /app

RUN apt-get update

RUN apt-get install -y git
RUN git config --global user.email "$GIT_EMAIL"
RUN git config --global user.name "$GIT_USERNAME"
RUN git config --global user.password "$GIT_PASSWORD"

CMD [ "sh", "/app/run.sh" ]
