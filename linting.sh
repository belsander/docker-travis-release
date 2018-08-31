#!/bin/bash

EXIT_CODE=0

SET_EXIT_CODE() {
  if [ "$1" -gt $EXIT_CODE ]
  then
    EXIT_CODE=$1
  fi
}

# Set globstar to search all directories (also nested)
shopt -s globstar

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
