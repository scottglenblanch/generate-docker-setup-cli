#!/bin/sh
APP_DIR=""
SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""
TAG=""

run_container() {
  docker run -it -v "${APP_DIR}":/app ${TAG}
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

  SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  APP_DIR="$("${SHARED_SCRIPTS_DIR}/get-app-dir.sh")"
  TAG="$("${SHARED_SCRIPTS_DIR}/get-tag-name.sh")"
}

set_variables
run_container
