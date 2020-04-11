#!/usr/bin/env bash

PUBLISH_DIR="$1"
REPO_PATH="$2"

cd "${PUBLISH_DIR}"

index=0
last_name=""

yq new version v2 > index.yaml
find . -name "*.tar.gz" | sort -r -V | while read -r file; do
  branch=$(basename $(dirname "${file}"))
  name=$(basename "${file}" | sed -E "s/^([a-z-]+)-([0-9]+[.][0-9]+[.][0-9]+).tar.gz/\1/g")
  version=$(basename "${file}" | sed -E "s/^([a-z-]+)-([0-9]+[.][0-9]+[.][0-9]+).tar.gz/\2/g")

  path=$(echo "${file}" | sed "s/^[.]\///g")

  if [[ "$last_name" != "${name}" ]]; then
    index=0
  else
    index=$((index+1))
  fi

  if [[ $index -eq 0 ]]; then
    yq w -i index.yaml "pipelines.${name}.url" "${REPO_PATH}/${path}"
    yq w -i index.yaml "pipelines.${name}.name" "${name}"
    yq w -i index.yaml "pipelines.${name}.version" "${version}"

    yq w -i index.yaml "branches.${branch}.${name}[+].url" "${REPO_PATH}/${path}"
    yq w -i index.yaml "branches.${branch}.${name}[$index].name" "${name}"
    yq w -i index.yaml "branches.${branch}.${name}[$index].version" "latest"

    index=$((index+1))
  fi

  yq w -i index.yaml "branches.${branch}.${name}[+].url" "${REPO_PATH}/${path}"
  yq w -i index.yaml "branches.${branch}.${name}[$index].name" "${name}"
  yq w -i index.yaml "branches.${branch}.${name}[$index].version" "${version}"

  last_name=$name
done
