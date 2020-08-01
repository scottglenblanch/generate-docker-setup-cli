#!/bin/bash

CUSTOM_SCRIPTS_DIR=""
SCRIPT_RUNNING_DIR=""

output_message() {
  echo "Running ${SCRIPT_RUNNING_DIR}/start-app.sh"
  echo "SCRIPT_RUNNING_DIR is ${SCRIPT_RUNNING_DIR}"
}

set_variables() {
  CUSTOM_SCRIPTS_DIR="/scripts/custom-scripts"
  SCRIPT_RUNNING_DIR="/scripts/image"
}

start_app() {
  "${CUSTOM_SCRIPTS_DIR}/start-app.sh"
}

set_variables
output_message
start_app