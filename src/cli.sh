#!/bin/sh

SCRIPT_RUNNING_DIR=""
APP_ROOT=""
TAG=""

create_docker_setup_in_app_root() {
  echo "copying"
}

is_not_valid() {
  if [[ -z "${APP_ROOT}" ]] || [[ -z "${TAG}" ]];
  then
    echo "true"
  else
    echo "false"
  fi
}

output_intro() {
  echo "Generating docker setup"
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  # APP_ROOT from --app-root
  # TAG from --tag
  source /dev/stdin <<< "$(curl https://raw.githubusercontent.com/scottglenblanch/bash-argument-parser/main/src/arg-parser.sh)"
}

output_intro
set_variables

if [[ "$(is_not_valid)" = "true" ]];
then
  echo "need arguments --app-root, --tag"
else
  create_docker_setup_in_app_root
fi

