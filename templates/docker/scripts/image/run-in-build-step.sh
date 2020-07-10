#!/bin/sh

SCRIPT_RUNNING_DIR=""

delete_image_scripts() {
  rm -rf /scripts/image
}
download_dependencies() {
  "${SCRIPT_RUNNING_DIR}/download-dependencies.sh"
}

output_message() {
  echo "Running ${SCRIPT_RUNNING_DIR}/run-in-build-step.sh"
  echo "SCRIPT_RUNNING_DIR is ${SCRIPT_RUNNING_DIR}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="/scripts/image"
}

set_variables
output_message
download_dependencies
delete_image_scripts