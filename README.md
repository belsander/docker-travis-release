# docker-travis-release

Template for automated Docker image builds using Travis

## How to use

Your repository should include the following files as a minimum to make it all
work:
```shell
.travis.yml
Dockerfile
release.sh
```
> At the moment no support yet for multiple Dockerfiles, create a ticket if
> needed

Copy the `release.sh` file into your repository, make sure it has the proper
permissions so that Travis can execute it.
```shell
chmod 775 release.sh
```

Modify release.sh variables which are declared on top of the file:
```shell
GH_USER='belsander'
GH_REPO='docker-travis-release'
VERSION_CMD="docker run -ti intelliops/travis-release:latest \
  /bin/bash -c 'echo 1.0.4'"
VERSION_FILE='VERSION'
```
Variable|Description
--------|-----------
GH_USER|Your Github username (or organisation name)
GH_REPO|The name of your Github repository (DO NOT INCLUDE .git EXTENSION)
VERSION_CMD|The command that will get the version of the service your are shipping with your container
VERSION_FILE|The name of the file where the VERSION will be stored into, best left untouched

>Make sure to strip any whitespace characters from the output of `VERSION_CMD`

Copy the `.travis.yml` file into your repository and modify it to your needs.
The most import part has to stay unchanged though:
```yaml
after_success:
  - if [[ "$TRAVIS_BRANCH" == "master" ]]; then ./release.sh; fi
```
