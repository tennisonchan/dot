#!/bin/bash
set +o posix

install_for_each_topic () {
  local topic=$1

  if [[ -n $topic ]]; then
    run_command "install" $topic;
  else
    all_topics | while read topic; do
      run_command "install" $topic;
    done
  fi;
}

install_for_each_topic $DOT_TOPIC;