#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
PUBLISH_DIR="$1"
REPO_PATH="$2"

if [[ -z "${PUBLISH_DIR}" ]]; then
  PUBLISH_DIR="publish"
fi

if [[ -z "${REPO_PATH}" ]]; then
  REPO_PATH="https://ibm-garage-cloud.github.io/garage-pipelines"
fi

"${SCRIPT_DIR}/package.sh" "${PUBLISH_DIR}"
"${SCRIPT_DIR}/index.sh" "${PUBLISH_DIR}" "${REPO_PATH}"
