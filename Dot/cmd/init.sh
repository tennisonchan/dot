#!/bin/bash

init () {
  if [[ -n $DOT_TOPIC ]]; then
    run_command "init" $DOT_TOPIC;
  else
    all_topics | while read topic; do
      run_command "init" $topic;
    done
  fi;
}

init;
source "$DOT_DIRECTORY/cmd/bundle.sh";
