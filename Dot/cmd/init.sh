#!/bin/bash
set +o posix

run_init_on_each_topic () {
  if [[ -n $DOT_TOPIC ]]; then
    run_command "init" $DOT_TOPIC;
  else
    all_topics | while read topic; do
      echo "Do you want to initialize for $topic? [y/n]"
      read -n 1 answer < /dev/tty;
      if [[ "$answer" == "y" ]]; then
        run_command "init" $topic;
      fi
    done
  fi;
}

run_init_on_each_topic;
source "$DOT_DIRECTORY/cmd/bundle.sh";
