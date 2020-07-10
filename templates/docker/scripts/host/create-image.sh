#!/bin/sh

SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""
CONFIG_DIR=""
APP_DIR=""
DOCKER_DIR=""
TAG=""

output_intro_message() {
  echo "Running ${SCRIPT_RUNNING_DIR}/create-image.sh"
}

output_variables_message() {
  echo "SCRIPT_RUNNING_DIR is ${SCRIPT_RUNNING_DIR}"
  echo "APP_DIR is ${APP_DIR}"
  echo "CONFIG_DIR is ${CONFIG_DIR}"
  echo "DOCKER_DIR is ${DOCKER_DIR}"
  echo "TAG is ${TAG}"
}

run_build() {
  docker build --tag "${TAG}" -f "${DOCKER_DIR}/Dockerfile" "${APP_DIR}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  APP_DIR="$("${SHARED_SCRIPTS_DIR}/get-app-dir.sh")"
  CONFIG_DIR="$("${SHARED_SCRIPTS_DIR}/get-config-dir.sh")"
  DOCKER_DIR="${APP_DIR}/docker"
  TAG="$("${SHARED_SCRIPTS_DIR}/get-tag-name.sh")"
}

output_intro_message
set_variables
output_variables_message

if [[ -z ${TAG} ]];
then
  echo "need name of tag in file located at ${CONFIG_DIR}/tagName"
  echo "this can be generated when you run ${SCRIPT_RUNNING_DIR}/set-image-tag-name.sh --tag <some tag name with no spaces>"
  exit 1
else
  run_build
fi


