#!/usr/bin/env bash

TARGET_BRANCH="$1"
PUBLISH_DIR="$2"

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  git checkout -b "${TARGET_BRANCH}" --track "origin/${TARGET_BRANCH}"
  cp -R "${PUBLISH_DIR}"/* .
  git add .
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
#  git remote add origin-pages https://${GH_TOKEN}@github.com/MVSE-outreach/resources.git > /dev/null 2>&1
#  git push --quiet --set-upstream origin-pages gh-pages
   git push
}

setup_git
commit_website_files
upload_files