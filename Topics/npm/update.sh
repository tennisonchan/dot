#!/bin/sh
set +o posix

source "$DOT_TOPIC_DIRECTORY/share.sh";

create_npmfile () {
  npm -g ls --json --depth=0 > $NPMFILE_PATH;
  echo "Updated file Npmfile";
}

create_npmfile;
