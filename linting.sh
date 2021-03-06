#!/bin/bash

source ENV

for DOCKERFILE in **/Dockerfile
do
  echo "* $DOCKERFILE"

  docker run --rm -i hadolint/hadolint <"$DOCKERFILE"
  RESULT=$?

  SET_EXIT_CODE $RESULT

  if [ "$RESULT" -eq 0 ]
  then
    echo "PASSED!"
  fi
done

exit "$EXIT_CODE"
