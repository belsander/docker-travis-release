#!/bin/bash

source ENV

for DOCKERFILE in **/Dockerfile
do
  echo "* $DOCKERFILE"
  DOCKER_NAME=$(get_name "$DOCKERFILE")

  docker stop "$DOCKER_NAME"
  docker rm -f "$DOCKER_NAME"
  RESULT=$?

  set_exit_code $RESULT

  if [ "$RESULT" -eq 0 ]
  then
    echo "STOPPED!"
  fi
done

exit "$EXIT_CODE"
