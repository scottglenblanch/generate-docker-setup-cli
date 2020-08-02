#!/bin/bash

APP_ROOT_DIR=""
BASE_SCRIPTS_DIR=""
DOCKER_DIR=""
HOST_SCRIPTS_DIR=""

CREATE_IMAGE=""
RUN_CONTAINER=""
SET_IMAGE_NAME=""
SET_TAG_NAME=""

set_variables() {
  set_app_root_dir() {
    SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    APP_ROOT_DIR="${SCRIPT_RUNNING_DIR}"
  }

  set_base_scripts_dir() {
    BASE_SCRIPTS_DIR="${DOCKER_DIR}/base-scripts"
  }

  set_docker_dir() {
    DOCKER_DIR="${APP_ROOT_DIR}/docker"
  }

  set_from_arguments() {
    ARGUMENT_PARSER_SCRIPT_URL="https://raw.githubusercontent.com/scottglenblanch/bash-argument-parser/main/src/arg-parser.sh"
    source /dev/stdin <<< "$(curl "${ARGUMENT_PARSER_SCRIPT_URL}")"
  }

  set_hosts_dir() {
    HOST_SCRIPTS_DIR="${BASE_SCRIPTS_DIR}/host"
  }

  set_app_root_dir
  set_docker_dir
  set_base_scripts_dir
  set_from_arguments $@
}

handle_input() {
  handle_create_image_request() {
    "${HOST_SCRIPTS_DIR}/create-image.sh"
  }

  handle_no_input_arguments() {
    echo 'Arguments: --create-image, --run-container, --set-image-name <image name>, --set-tag-name <tag name>'
    echo '--create-image will create/build the Docker image for you'
    echo '--run-container will start everything in a container for you'
    echo '--set-image-name <image name to insert> will set the base Docker image'
    echo '--set-tag-name <tag name to use> will set the image tag name for the application'
  }

  handle_run_container_request() {
    "${HOST_SCRIPTS_DIR}/run-container.sh"
  }

  handle_set_image_name_request() {
    IMAGE="${SET_IMAGE_NAME}"
    "${HOST_SCRIPTS_DIR}/set-base-image-name.sh" --image "${IMAGE}"
  }

  handle_set_container_tag_name_request() {
    TAG="${SET_TAG_NAME}"
    "${HOST_SCRIPTS_DIR}/set-container-tag-name.sh" --tag "${TAG}"
  }

  if [ "${CREATE_IMAGE}" != "" ];
  then
    handle_create_image_request
  elif [ "${RUN_CONTAINER}" != "" ];
  then
    handle_run_container_request
  elif [ "${SET_IMAGE_NAME}" != "" ];
  then
    handle_set_image_name_request
  elif [ "${SET_TAG_NAME}" != "" ];
  then
    handle_set_container_tag_name_request
  else
    handle_no_input_arguments
  fi
}

set_variables $@
handle_input $@
