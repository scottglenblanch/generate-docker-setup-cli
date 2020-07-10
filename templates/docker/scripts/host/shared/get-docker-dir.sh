#!/bin/bash

SCRIPT_RUNNING_DIR=""
APP_DIR=""
DOCKER_DIR=""

output_message() {
  echo "${DOCKER_DIR}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  APP_DIR="$("${SCRIPT_RUNNING_DIR}/get-app-dir.sh")"
  DOCKER_DIR="${APP_DIR}/docker"
}

set_variables
output_message