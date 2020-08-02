#!/bin/bash

#!/bin/bash

CONFIG_DIR=""
CONFIG_FILE_LOCATION=""
PORTS=""
PORTS_CONFIG_FILE_CONTENT=""
SCRIPT_RUNNING_DIR=""
SHARED_SCRIPTS_DIR=""

create_file() {
  mkdir -p "${CONFIG_DIR}"

  echo -e "${PORTS_CONFIG_FILE_CONTENT}" > "${CONFIG_FILE_LOCATION}"
}

set_ports_config_content() {
  TMP_MESSAGE=""

  for PORT_NUMBER in ${PORTS};
  do
    TMP_MESSAGE+="${PORT_NUMBER}\n"
  done

  PORTS_CONFIG_FILE_CONTENT="${TMP_MESSAGE}"
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  SHARED_SCRIPTS_DIR="${SCRIPT_RUNNING_DIR}/shared"
  # will set PORTS from arguments --ports <some arguments>
  source "${SHARED_SCRIPTS_DIR}/parse-args.sh"
  CONFIG_DIR="$("${SHARED_SCRIPTS_DIR}/get-config-dir.sh")"
  CONFIG_FILE_LOCATION="${CONFIG_DIR}/ports"
  set_ports_config_content
}

set_variables $@

if [[ -z "${PORTS}" ]];
then
   echo "need --ports <port numbers separated by white space> as argument"
else
  create_file
fi