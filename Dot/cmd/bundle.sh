#!/bin/bash

bundle_on_topics () {
  if [[ -n $DOT_TOPIC ]]; then
    run_command "bundle" $DOT_TOPIC
  fi;
}

bundle_on_topics
source "$DOT_DIRECTORY/cmd/update.sh";
source "$DOT_DIRECTORY/cmd/symlink.sh";