FROM  ubuntu:18.04

ARG   UBUNTU_VERSION=18.04
ARG   TRAVIS_RELEASE_VERSION=1.0.0
ARG   RELEASE_DATE=2018-08-31

LABEL maintainer='Sander Bel <sander@intelliops.be>'
LABEL ubuntu.version=$UBUNTU_VERSION
LABEL travis.release.version=$TRAVIS_RELEASE_VERSION
LABEL release-date=$RELEASE_DATE

RUN   echo 'This is template to release versioned Docker images by using Travis'

RUN   printf """Build arguments:\\n\
        UBUNTU_VERSION: %s\\n\
        TRAVIS_RELEASE_VERSION: %s\\n\
        RELEASE_DATE: %s\\n""" \
        ${UBUNTU_VERSION} ${TRAVIS_RELEASE_VERSION} ${RELEASE_DATE}
