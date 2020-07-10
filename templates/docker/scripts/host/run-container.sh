#!/bin/sh
APP_DIR=""
CONFIG_DIR=""
CONFIG_PORTS_FILE_LOCATION=""
PORTS_DOCKER_STRING=""
SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""
TAG=""

set_ports_docker_string() {
  PORTS_CONFIG_FILE_CONTENTS="$(cat "${CONFIG_PORTS_FILE_LOCATION}")"

  IFS='
  '

  for PORT in ${PORTS_CONFIG_FILE_CONTENTS};
  do
    PORTS_DOCKER_STRING="${PORTS_DOCKER_STRING} -p ${PORT}:${PORT}"
  done
}

run_container() {
  echo "Running docker run command: docker run -it -v "${APP_DIR}":/app ${PORTS_DOCKER_STRING} ${TAG}"
  docker run -it -v "${APP_DIR}":/app ${PORTS_DOCKER_STRING} ${TAG}
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

  SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  APP_DIR="$("${SHARED_SCRIPTS_DIR}/get-app-dir.sh")"
  CONFIG_DIR="$("${SHARED_SCRIPTS_DIR}/get-config-dir.sh")"
  CONFIG_PORTS_FILE_LOCATION="${CONFIG_DIR}/ports"
  TAG="$("${SHARED_SCRIPTS_DIR}/get-tag-name.sh")"
  set_ports_docker_string
}

set_variables
run_container
