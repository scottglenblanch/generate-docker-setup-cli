#!/bin/sh
APP_ROOT=""
SCRIPT_RUNNING_DIR=""
TAG=""
UNZIPPED_NAME=""
UNZIPPED_DIR=""
UNZIPPED_DOCKER_DIR=""
ZIP_FILE_LOCATION=""
ZIP_FILE_NAME=""
ZIP_URL=""

create_docker_setup_in_app_root() {
  clean_up_zip() {
    rm -rf "${ZIP_FILE_LOCATION}"
    rm -rf "${UNZIPPED_DIR}"
  }

  download_zip() {
    cd "${APP_ROOT}"
    curl -o "${ZIP_FILE_NAME}" -LOk "${ZIP_URL}"
    tar xvf "${ZIP_FILE_NAME}"
  }

  move_docker_template_to_app_root() {
    mv "${UNZIPPED_DOCKER_DIR}" "${APP_ROOT}"
  }

  unzip_zip_file() {
    cd "${APP_ROOT}"
    tar -xvf "${ZIP_FILE_NAME}"
  }

  download_zip
  unzip_zip_file
  move_docker_template_to_app_root
  clean_up_zip
}

create_tag_config() {
  "${APP_ROOT}/docker/scripts/host/set-image-tag-name.sh" --tag "${TAG}"
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

  UNZIPPED_NAME="generate-docker-setup-cli-main"
  UNZIPPED_DIR="${APP_ROOT}/${UNZIPPED_NAME}"
  UNZIPPED_DOCKER_DIR="${UNZIPPED_DIR}/templates/docker"

  ZIP_FILE_NAME="downloaded_item.zip"
  ZIP_FILE_LOCATION="${APP_ROOT}/${ZIP_FILE_NAME}"
  ZIP_URL="https://github.com/scottglenblanch/generate-docker-setup-cli/archive/main.zip"

  echo "${UNZIPPED_DOCKER_DIR}"
}

output_intro
set_variables $@

if [[ "$(is_not_valid)" = "true" ]];
then
  echo "need arguments --app-root, --tag"
else
  create_docker_setup_in_app_root
  create_tag_config
fi

