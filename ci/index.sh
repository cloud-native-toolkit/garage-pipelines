#!/usr/bin/env bash

PUBLISH_DIR="$1"
REPO_PATH="$2"

cd "${PUBLISH_DIR}"

yq new name garage-pipelines > index.yaml
find . -name "*.tar.gz" | while read -r file; do
  name=$(basename "${file}" | cut -f 1 -d '.')
  path=$(echo "${file}" | sed "s/^[.]\///g")
  yq w -i index.yaml "pipelines.${name}.url" "${REPO_PATH}/${path}"
  yq w -i index.yaml "pipelines.${name}.name" "${name}"
done
