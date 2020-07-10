#!/bin/sh

TAG=""

run_container() {
  docker run -it ${TAG}
}

set_variables() {
  SCRIPT_RUNNING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  # will set TAG if has argument --tag <some value>
  source /dev/stdin <<< "$(curl https://raw.githubusercontent.com/scottglenblanch/bash-argument-parser/main/src/arg-parser.sh)"
}

set_variables
run_container

