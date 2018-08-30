#!/bin/bash
set -e

############# CUSTOM VARIABLES, SET THESE TO YOUR NEEDS #############
GH_USER='belsander'
GH_REPO='docker-travis-release'
VERSION_FILE='VERSION'
VERSION_CMD="docker run -ti intelliops/travis-release:latest \
  /bin/bash -c 'echo 1.0.4'"
#####################################################################


############## DO NOT MODIFY ANYTHING BELOW THIS LINE  ##############
REPO="$GH_USER/$GH_REPO.git"

setup_git() {
  # Configure git credentials for commit messages etc
  git config --global user.email 'sander@intelliops.be'
  git config --global user.name 'Sander Bel (Travis CI)'
}

get_current_version() {
  {
    cat $VERSION_FILE 2>/dev/null
  } || {
    # No VERSION_FILE, so no versioned releases yet
    echo "UNRELEASED"
  }
}

get_new_version() {
  # Get version of binary to be released
  RESULT=$(eval "$VERSION_CMD")
  # Filter result from tabs, whitespaces and newlines
  echo "${RESULT//[$'\t\r\n ']}"
}

set_version() {
  # Set version in VERSION_FILE, used for tracking version in GitHub
  echo "$1" > $VERSION_FILE
}

commit_version() {
  # Commit new version in VERSION_FILE
  git add $VERSION_FILE >/dev/null 2>&1
  git commit --message "Bumped version: $1 -> $2" >/dev/null 2>&1
}

tag_version() {
  # Create tag at current commit
  TAG="$1"
  git tag "$TAG" >/dev/null 2>&1
  echo "$TAG"
}

push_changes() {
  # Push local changes to GitHub (auth via ENV variable)
  git remote add auth "https://${GH_TOKEN}@github.com/$REPO" >/dev/null 2>&1
  git push --follow-tags --set-upstream auth HEAD:master
  # The above does not push the tag sadly, so doing it with an extra command
  git push auth "$1"
}


# MAIN
echo "######################################################################"
echo "Releasing GitHub \"${REPO}\" ..."
echo "######################################################################"
setup_git

OLD_VERSION=$(get_current_version)
echo "Latest release binary version: \"${OLD_VERSION}\""
VERSION=$(get_new_version)
echo "Current binary version: \"${VERSION}\""
echo "######################################################################"

if [[ "$OLD_VERSION" == "$VERSION" ]]
then
  echo 'Latest release of binary is already present in last Docker image,'\
    'not releasing a new version'
else
  echo 'Newer version of binary found, releasing a new version!'
  echo "######################################################################"

  set_version "$VERSION"

  commit_version "$OLD_VERSION" "$VERSION"
  git show HEAD
  echo "######################################################################"

  TAG=$(tag_version "$VERSION")
  echo 'Listing all Git tags:'
  git tag -l
  echo "######################################################################"

  push_changes "$TAG"
  echo "Released GitHub \"${REPO}\" with version: \"${VERSION}\""
fi
