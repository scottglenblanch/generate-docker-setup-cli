#!/bin/sh

SCRIPT_RUNNING_DIR=""
CONFIG_DIR=""
FILE_WITH_TAG_NAME=""

output_message() {
  cat "${FILE_WITH_TAG_NAME}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  CONFIG_DIR="$("${SCRIPT_RUNNING_DIR}/get-config-dir.sh")"
  FILE_WITH_TAG_NAME="${CONFIG_DIR}/tagName"
}

set_variables
output_message
