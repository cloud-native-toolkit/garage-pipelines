#!/usr/bin/env bash

REPO_PATH="$1"

yq new name garage-pipelines > index.yaml
find . -name "*.tar.gz" | while read -r file; do
  name=$(basename "${file}" | cut -f 1 -d '.')
  path=$(echo "${file}" | sed "s/^[.]\///g")
  yq w -i index.yaml "${name}.url" "${REPO_PATH}/${path}"
  yq w -i index.yaml "${name}.name" "${name}"
done
