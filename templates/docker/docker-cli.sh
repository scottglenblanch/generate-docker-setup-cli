#!/bin/bash

APP_ROOT_DIR=""
DOCKER_DIR=""

CREATE_IMAGE=""
RUN_CONTAINER=""
SET_IMAGE_NAME=""
SET_TAG_NAME=""

set_variables() {
  set_app_root_dir() {
    SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    APP_ROOT_DIR="${SCRIPT_RUNNING_DIR}"
  }

  set_docker_dir() {
    DOCKER_DIR="${APP_ROOT_DIR}/docker"
  }

  set_from_arguments() {
    ARGUMENT_PARSER_SCRIPT_URL="https://raw.githubusercontent.com/scottglenblanch/bash-argument-parser/main/src/arg-parser.sh"
    source /dev/stdin <<< "$(curl "${ARGUMENT_PARSER_SCRIPT_URL}")"
  }

  set_app_root_dir
  set_docker_dir
  set_from_arguments $@
}

handleInput() {
  handle_create_image_request() {
    "${DOCKER_DIR}/scripts/host/create-image.sh"
  }

  handle_no_input_arguments() {
    echo 'Arguments: --create-image, --run-container, --set-image-name <image name>, --set-tag-name <tag name> '
  }

  handle_run_container_request() {
    "${DOCKER_DIR}/scripts/host/run-container.sh"
  }

  handle_set_image_name_request() {
    IMAGE="${SET_IMAGE_NAME}"
    "${DOCKER_DIR}/scripts/host/set-base-image-name.sh" --image "${IMAGE}"
  }

  handle_set_container_tag_name_request() {
    TAG="${SET_TAG_NAME}"
    "${DOCKER_DIR}/scripts/host/set-container-tag-name.sh" --tag "${TAG}"
  }

  if [ "${CREATE_IMAGE}" != "" ]
  then
    handle_create_image_request
  elif [ -n "${RUN_CONTAINER}" != "" ]
    handle_run_container_request
  elif [ -n "${SET_IMAGE_NAME}" != "" ]
    handle_set_image_name_request
  elif [ "${SET_TAG_NAME}" != "" ];
    handle_set_container_tag_name_request
  else
    handle_no_input_arguments
  fi
}

set_variables $@
handle_input $@
