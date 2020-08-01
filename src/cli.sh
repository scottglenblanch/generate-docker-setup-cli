#!/bin/sh
APP_ROOT=""
IMAGE=""
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
  set_variables_from_arguments() {
    set_variables_from_bash_parser() {
      BASH_ARGUMENT_PARSER_URL='https://raw.githubusercontent.com/scottglenblanch/bash-argument-parser/main/src/arg-parser.sh'

      source /dev/stdin <<< "$(curl "${BASH_ARGUMENT_PARSER_URL}")"
    }

    set_variables_to_default_if_not_set() {
      set_variable_app_root_default() {
        APP_ROOT="$(pwd)"
      }

      set_variable_image_default() {
        IMAGE='alpine'
      }

      set_variable_tag_default() {
        TAG="image-tag-$(date +%s)"
      }

      [ -z "${APP_ROOT}" ] && set_variable_app_root_default
      [ -z "${IMAGE}" ] && set_variable_image_default
      [ -z "${TAG}" ] && set_variable_tag_default
    }

    set_variables_from_bash_parser
    set_variables_to_default_if_not_set
  }

  set_unzipped_variables() {
    UNZIPPED_NAME="generate-docker-setup-cli-main"
    UNZIPPED_DIR="${APP_ROOT}/${UNZIPPED_NAME}"
    UNZIPPED_DOCKER_DIR="${UNZIPPED_DIR}/templates/docker"
  }

  set_zipped_variables() {
    ZIP_FILE_NAME="downloaded_item.zip"
    ZIP_FILE_LOCATION="${APP_ROOT}/${ZIP_FILE_NAME}"
    ZIP_URL="https://github.com/scottglenblanch/generate-docker-setup-cli/archive/main.zip"
  }

  set_variables_from_arguments
	set_unzipped_variables
  set_zipped_variables
}

output_intro
set_variables $@
create_docker_setup_in_app_root
create_tag_config


