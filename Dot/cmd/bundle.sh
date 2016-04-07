#!/bin/bash

echo "bundle.sh"

run_bundle () {
  if [[ -f "$DOT_TOPICS_DIRECTORY/$1/$DOT_COMMAND.sh" ]]; then
    source "$DOT_TOPICS_DIRECTORY/$1/$DOT_COMMAND.sh";
  fi;
}

if [[ -n $DOT_TOPIC ]]; then
  run_update $DOT_TOPIC;
else
  ls $DOT_TOPICS_DIRECTORY | while read topic; do
    set_topic "$topic";
    run_update $topic;
  done
fi;
