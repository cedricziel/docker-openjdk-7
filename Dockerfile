FROM ubuntu:14.04
MAINTAINER Cedric Ziel "cedric@cedric-ziel.com"

RUN echo deb http://archive.ubuntu.com/ubuntu trusty universe >> /etc/apt/sources.list
RUN apt-get update && apt-get clean
RUN apt-get install -q -y openjdk-7-jre-headless && apt-get clean
