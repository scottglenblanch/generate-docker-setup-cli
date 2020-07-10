#!/bin/sh

SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""
TAG=""

run_container() {
  docker run -it ${TAG}
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  TAG="$("${SHARED_SCRIPTS_DIR}/get-tag-name.sh")"
}

set_variables
run_container
