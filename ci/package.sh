#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname $0); pwd -P)
BASE_DIR=$(cd ${SCRIPT_PATH}/..; pwd -P)

DIR_PATH="stable"

for item in $DIR_PATH; do
  find ${BASE_DIR}/${item} -mindepth 1 -maxdepth 1 | while read path; do
    pipeline=$(basename "${path}")
    mkdir -p "${BASE_DIR}/tmp/${item}"
    cd "${path}"
    tar czf "${BASE_DIR}/tmp/${item}/${pipeline}.tar.gz" .
  done
done
