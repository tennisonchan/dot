#!/bin/bash
set +o posix

if [[ -n $DOT_TOPIC ]]; then
  run_command "install" $DOT_TOPIC;
else
  ls $DOT_TOPICS_DIRECTORY | while read topic; do
    run_command "install" $topic;
  done
fi;
