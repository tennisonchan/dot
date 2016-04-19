#!/bin/sh
set +o posix

source "$DOT_TOPIC_DIRECTORY/share.sh";

update_npmfile () {
  local npmfile=$1
  npm -g ls --json --depth=0 > $npmfile;
  echo "Updated file Npmfile";
}

update_npmfile $NPMFILE_PATH;
