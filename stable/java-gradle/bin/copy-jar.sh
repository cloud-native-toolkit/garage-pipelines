#!/usr/bin/env bash

LIB_PATH="$1"

ls "${LIB_PATH}"/*.jar | grep -v server.jar | while read -r jar; do
  cp "${jar}" "${LIB_PATH}/server.jar"
  break
done
