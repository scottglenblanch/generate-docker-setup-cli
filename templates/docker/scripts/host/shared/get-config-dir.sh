#!/bin/sh

SCRIPT_RUNNING_DIR=""
DOCKER_DIR=""
CONFIG_DIR=""

output_message() {
  echo "${CONFIG_DIR}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  DOCKER_DIR="$("${SCRIPT_RUNNING_DIR}/get-docker-dir.sh")"
  CONFIG_DIR="${DOCKER_DIR}/config"
}

set_variables
output_message
