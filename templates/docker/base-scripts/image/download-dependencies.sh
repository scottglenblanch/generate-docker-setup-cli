#!/bin/sh

CUSTOM_SCRIPTS_DIR=""
SCRIPT_RUNNING_DIR=""


download_dependencies() {
  apk add bash
  "${CUSTOM_SCRIPTS_DIR}/download-dependencies.sh"
}

output_message() {
  echo "Running ${SCRIPT_RUNNING_DIR}/download-dependencies.sh"
  echo "SCRIPT_RUNNING_DIR is ${SCRIPT_RUNNING_DIR}"
}

set_variables() {
  CUSTOM_SCRIPTS_DIR="/scripts/custom-scripts"
  SCRIPT_RUNNING_DIR="/scripts/image"
}

set_variables
output_message
download_dependencies