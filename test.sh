#!/bin/bash

source ENV

for DOCKERFILE in **/Dockerfile
do
  echo "* $DOCKERFILE"
  DOCKER_NAME=$(get_name "$DOCKERFILE")

  docker run --name "$DOCKER_NAME" "$DOCKER_IMAGE:$DOCKER_NAME"
  # Run tests here
  RESULT=$?

  set_exit_code $RESULT

  if [ "$RESULT" -eq 0 ]
  then
    echo "PASSED!"
  fi
done

set -e

docker ps -a

exit "$EXIT_CODE"
