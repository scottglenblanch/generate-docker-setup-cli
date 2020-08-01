#!/bin/bash
APP_DIR=""
BASE_IMAGE=""
CONFIG_DIR=""
DOCKER_DIR=""
SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""
TAG=""

output_intro_message() {
  echo "Running ${SCRIPT_RUNNING_DIR}/create-image.sh"
}

output_variables_message() {
  echo "APP_DIR is ${APP_DIR}"
  echo "BASE_IMAGE is ${BASE_IMAGE}"
  echo "CONFIG_DIR is ${CONFIG_DIR}"
  echo "DOCKER_DIR is ${DOCKER_DIR}"
  echo "SCRIPT_RUNNING_DIR is ${SCRIPT_RUNNING_DIR}"
  echo "TAG is ${TAG}"
}

run_build() {
  docker build \
    --tag "${TAG}" \
    -f "${DOCKER_DIR}/Dockerfile" \
    --build-arg BASE_IMAGE="${BASE_IMAGE}" \
    "${APP_DIR}"
}

set_variables() {
  set_app_dir() {
    APP_DIR="$("${SHARED_SCRIPTS_DIR}/get-app-dir.sh")"
  }

  set_base_image() {
    BASE_IMAGE="$("${SHARED_SCRIPTS_DIR}/get-base-image-name.sh")"
  }

  set_config_dir() {
    CONFIG_DIR="$("${SHARED_SCRIPTS_DIR}/get-config-dir.sh")"
  }

  set_docker_dir() {
    DOCKER_DIR="${APP_DIR}/docker"
  }

  set_script_running_dir() {
    SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  }

  set_shared_scripts_dir() {
    SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  }

  set_tag() {
    TAG="$("${SHARED_SCRIPTS_DIR}/get-tag-name.sh")"
  }

  set_script_running_dir
  set_shared_scripts_dir

  set_app_dir
  set_base_image
  set_config_dir
  set_docker_dir
  set_tag
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


