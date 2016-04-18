#!/bin/bash
set +o posix

run_init_on_each_topic () {
  local topic=$1

  if [[ -n $topic ]]; then
    run_command "init" $topic;
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

run_init_on_each_topic $DOT_TOPIC;
source "$DOT_DIRECTORY/cmd/bundle.sh";
