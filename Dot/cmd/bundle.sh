#!/bin/bash
set +o posix

bundle_on_topics () {
  local topic=$1
  if [[ -n $topic ]]; then
    run_command "bundle" $topic
  fi;
}

bundle_on_topics $DOT_TOPIC;
source "$DOT_DIRECTORY/cmd/backup.sh";
