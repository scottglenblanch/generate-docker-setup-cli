#!/bin/bash

SCRIPT_RUNNING_DIR=""

output_message() {
  echo "Running ${SCRIPT_RUNNING_DIR}/start-app.sh"
  echo "SCRIPT_RUNNING_DIR is ${SCRIPT_RUNNING_DIR}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="/scripts/image"
}

start_app() {
  echo "no app to start"
}

set_variables
output_message
start_app