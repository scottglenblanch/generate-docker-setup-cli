#!/bin/sh
APP_DIR=""
CONFIG_DIR=""
CONFIG_PORTS_FILE_LOCATION=""
SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""
TAG=""

get_ports() {
  PORTS_CONFIG="$(cat "${CONFIG_PORTS_FILE_LOCATION}")"

  IFS='
  '

  for PORT in ${PORTS_CONFIG};
  do
    echo "${PORT}"
  done
}

run_container() {
  get_ports

  docker run -it -v "${APP_DIR}":/app ${TAG}
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

  SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  APP_DIR="$("${SHARED_SCRIPTS_DIR}/get-app-dir.sh")"
  CONFIG_DIR="$("${SHARED_SCRIPTS_DIR}/get-config-dir.sh")"
  CONFIG_PORTS_FILE_LOCATION="${CONFIG_DIR}/ports"
  TAG="$("${SHARED_SCRIPTS_DIR}/get-tag-name.sh")"
}

set_variables
run_container
