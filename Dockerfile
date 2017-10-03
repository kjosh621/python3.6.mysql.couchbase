FROM ubuntu:16.04

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# Install common
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y vim wget curl bash-completion


# Install python 3.6 & mysql-connector
RUN \
  add-apt-repository ppa:jonathonf/python-3.6 && \
  apt-get update && \
  apt-get install -y python-pip python3.6 && \
  pip install mysql-connector-python-rf

# Install couchbase dev tools
RUN wget http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-2-amd64.deb && \
  dpkg -i couchbase-release-1.0-2-amd64.deb && \
  apt-get update && \
  apt-get -y install libcouchbase-dev build-essential python-dev python-pip && pip install couchbase && \
  rm -rf /var/lib/apt/lists/*

RUN rm /usr/bin/python && ln -s /usr/bin/python3.6 /usr/bin/python

WORKDIR /opt/warming_engine

CMD ["python"]

