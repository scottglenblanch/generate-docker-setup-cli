#!/bin/sh

CONFIG_DIR=""
CONFIG_FILE_LOCATION=""
SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""
TAG=""

create_file() {
  mkdir -p "${CONFIG_DIR}"
  echo "${TAG}" > "${CONFIG_FILE_LOCATION}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  # will set TAG from arguments --tag <some arguments>
  source "${SHARED_SCRIPTS_DIR}/parse-args.sh"
  CONFIG_DIR="$("${SHARED_SCRIPTS_DIR}/get-config-dir.sh")"
  CONFIG_FILE_LOCATION="${CONFIG_DIR}/tagName"
}

set_variables $@

if [[ -z "${TAG}" ]];
then
   echo "need --tag <some non-empty tag name with no spaces> as argument"
else
  create_file
fi


