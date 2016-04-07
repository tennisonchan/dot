#!/bin/bash

echo "Dot/install"

if [[ -n $DOT_TOPIC ]]; then
  run_command "install" $DOT_TOPIC;
else
  ls $DOT_TOPICS_DIRECTORY | while read topic; do
    set_topic "$topic";
    run_command "install" $topic;
  done
fi;
