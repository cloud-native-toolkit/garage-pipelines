#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname $0); pwd -P)
BASE_DIR=$(cd ${SCRIPT_PATH}/..; pwd -P)

PUBLISH_DIR="$1"

TMP_DIR="./tmp"
mkdir -p $TMP_DIR

DIR_PATH="stable"

for item in $DIR_PATH; do
  find "${BASE_DIR}/${item}" -mindepth 1 -maxdepth 1 | while read -r path; do
    pipeline=$(yq r "${path}/pipeline.yaml" name)
    version=$(yq r "${path}/pipeline.yaml" version)

    TMP_PATH="${TMP_DIR}/${pipeline}"
    mkdir -p "${TMP_PATH}"
    cp -R "${path}"/* "${TMP_PATH}"

    # Add the version number to the top of the Jenkinsfile
    echo "def pipelineVersion='${version}'" > "${TMP_PATH}/Jenkinsfile"
    echo 'println "Pipeline version: ${pipelineVersion}"' >> "${TMP_PATH}/Jenkinsfile"
    cat $(find "${path}" -name Jenkinsfile) >> "${TMP_PATH}/Jenkinsfile"

    # update the helm chart version number
    yq w --inplace $(find "${TMP_PATH}" -name Chart.yaml) version "${version}"

    mkdir -p "${BASE_DIR}/${PUBLISH_DIR}/${item}"
    cd "${TMP_PATH}"

    tar czf "${BASE_DIR}/${PUBLISH_DIR}/${item}/${pipeline}-${version}.tar.gz" .

    cd - > /dev/null
  done
done

rm -rf ${TMP_DIR}
