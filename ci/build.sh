#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
REPO_PATH="$1"

if [[ -z "${REPO_PATH}" ]]; then
  REPO_PATH="https://ibm-garage-cloud.github.io/garage-pipelines"
fi

"${SCRIPT_DIR}/package.sh"
"${SCRIPT_DIR}/publish.sh"
"${SCRIPT_DIR}/index.sh" "${REPO_PATH}"
