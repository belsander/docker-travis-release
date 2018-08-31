FROM  ubuntu:16.04

ARG   UBUNTU_VERSION=16.04
ARG   TRAVIS_RELEASE_VERSION=1.0.0
ARG   RELEASE_DATE=2018-08-31

LABEL maintainer='Sander Bel <sander@intelliops.be>'
LABEL ubuntu.version=$UBUNTU_VERSION
LABEL travis.release.version=$TRAVIS_RELEASE_VERSION
LABEL release-date=$RELEASE_DATE

RUN   echo 'This is template to release versioned Docker images by using Travis'

RUN   echo "Build arguments: \n" \
        " UBUNTU_VERSION: $UBUNTU_VERSION\n" \
        " TRAVIS_RELEASE_VERSION: ${TRAVIS_RELEASE_VERSION}\n" \
        " RELEASE_DATE: ${RELEASE_DATE}"
