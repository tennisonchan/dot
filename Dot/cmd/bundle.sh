#!/bin/bash

echo "Dot/bundle"

if [[ -n $DOT_TOPIC ]]; then
  run_command "bundle" $DOT_TOPIC
else
  all_topics | while read topic; do
    set_topic "$topic"
    run_command "bundle" $topic
  done
fi;
