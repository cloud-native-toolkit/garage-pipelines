#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname "$0"); pwd -P)

TARGET_BRANCH="$1"
PUBLISH_DIR="$2"
REPO_URL="$3"

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"

  set -x
  git remote -v
  git fetch origin --unshallow -v
  git fetch origin gh-pages --unshallow -v
  git checkout -b "${TARGET_BRANCH}" --track "origin/${TARGET_BRANCH}"
}

publish_content() {
  cp -R "${PUBLISH_DIR}"/* . && rm -rf "${PUBLISH_DIR}"
}

generate_index() {
  "${SCRIPT_PATH}/index.sh" ./ "${REPO_URL}"
}

commit_website_files() {
  git add .
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
#  git remote add origin-pages https://${GH_TOKEN}@github.com/MVSE-outreach/resources.git > /dev/null 2>&1
#  git push --quiet --set-upstream origin-pages gh-pages
   git push
}

setup_git
publish_content
generate_index
commit_website_files
upload_files
