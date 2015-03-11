##dockerizing mongoDB
# Based on ubuntu:14.04, installs MongoDB following the instructions from:
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

FROM    ubuntu:14.04

MAINTAINER Kristina Hager <kristina.hager@gmail.com>

RUN echo ".git" > .dockerignore

# Installation - get mongo db packages:
ENV MONGODB_VERSION 2.6.8
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
RUN apt-get update && \
    apt-get install -y mongodb-org=$MONGODB_VERSION \
    mongodb-org-server=$MONGODB_VERSION \
    mongodb-org-shell=$MONGODB_VERSION \
    mongodb-org-mongos=$MONGODB_VERSION \
    mongodb-org-tools=$MONGODB_VERSION

# Create the MongoDB data directory
RUN mkdir -p /data/db

# Not going to expose port of DB to network at this point
EXPOSE 27017

# set usr/bin/mongod as the dockerized entry-point application
ENTRYPOINT usr/bin/mongod


