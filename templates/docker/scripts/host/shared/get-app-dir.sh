#!/bin/sh

SCRIPT_RUNNING_DIR=""
APP_DIR=""

output_message() {
  echo "${APP_DIR}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  APP_DIR="$(cd ${SCRIPT_RUNNING_DIR}; cd ../../../..; pwd)"
}

set_variables
output_message
