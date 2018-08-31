# hadolint ignore=DL3007
FROM  ubuntu:latest

ARG   UBUNTU_VERSION=latest
ARG   TRAVIS_RELEASE_VERSION=latest
ARG   RELEASE_DATE=automated-build-latest

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
