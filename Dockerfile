FROM ubuntu:14.04
MAINTAINER Cedric Ziel "cedric@cedric-ziel.com"

RUN echo deb http://archive.ubuntu.com/ubuntu trusty universe >> /etc/apt/sources.list

# Fake a FUSE install -- necessary for installing Java :(
# <https://gist.github.com/henrik-muehe/6155333>
# <https://github.com/dotcloud/docker/issues/514>
RUN apt-get install -y libfuse2
RUN cd /tmp ; apt-get download fuse
RUN cd /tmp ; dpkg-deb -x fuse_* .
RUN cd /tmp ; dpkg-deb -e fuse_*
RUN cd /tmp ; rm fuse_*.deb
RUN cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst
RUN cd /tmp ; dpkg-deb -b . /fuse.deb
RUN cd /tmp ; dpkg -i /fuse.deb

RUN apt-get update && apt-get clean
RUN apt-get install -q -y openjdk-7-jre-headless openjdk-7-jdk && apt-get clean
