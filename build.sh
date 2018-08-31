#!/bin/bash

source ENV

for DOCKERFILE in **/Dockerfile
do
  echo "* $DOCKERFILE"
  DOCKER_NAME=$(get_name "$DOCKERFILE")

  docker build -f "$DOCKERFILE" --tag "$DOCKER_IMAGE:$DOCKER_NAME" .
  RESULT=$?

  set_exit_code $RESULT

  if [ "$RESULT" -eq 0 ]
  then
    echo "PASSED!"
  fi
done

exit "$EXIT_CODE"
