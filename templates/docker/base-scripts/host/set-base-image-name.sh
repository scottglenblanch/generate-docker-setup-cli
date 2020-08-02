#!/bin/bash

# will set TAG from arguments --image <some arguments>

CONFIG_DIR=""
CONFIG_FILE_LOCATION=""
SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""
IMAGE=""

create_file() {
  mkdir -p "${CONFIG_DIR}"
  echo "${IMAGE}" > "${CONFIG_FILE_LOCATION}"
}

set_variables() {
  set_config_variables() {
    CONFIG_DIR="$("${SHARED_SCRIPTS_DIR}/get-config-dir.sh")"
    CONFIG_FILE_LOCATION="${CONFIG_DIR}/baseImage"
  }

  set_shared_scripts_variable() {
    SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  }

  set_variables_from_terminal_input() {
    source "${SHARED_SCRIPTS_DIR}/parse-args.sh" $@
  }

  set_shared_scripts_variable $@
  set_variables_from_terminal_input $@
  set_config_variables $@
}

set_variables $@

if [[ -z "${IMAGE}" ]];
then
  echo "need --image (some non-empty image name with no spaces) as argument"
  exit 1
else
  create_file
fi
