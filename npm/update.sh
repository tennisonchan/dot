#!/bin/sh
#
#   Update the .npmfile based on npm global packages on the local machine.
#   Add and commit .npmfile.

NPM_ROOT_PATH="$(npm root -g)"
NPMLIST_FILE_PATH="$(pwd)/.npmlist"
NPMFILE_PATH="$(pwd)/.npmfile"
TMP_NPMFILE_PATH="/tmp/.npmfile"

if [ -f $NPMLIST_FILE_PATH ] && [ "$NPMLIST" == "$(cat $NPMLIST_FILE_PATH)" ]; then
  echo "npmfile is up-to-date."
else
  ls -1 $NPM_ROOT_PATH > $NPMLIST_FILE_PATH

  cat $NPMLIST_FILE_PATH | while read line; do
    echo $line@$(npm info $line version)
  done > $TMP_NPMFILE_PATH

  if [ -f $NPMFILE_PATH ] && [ "$(cat $NPMFILE_PATH)" == "$(cat $TMP_NPMFILE_PATH)" ]; then
    echo "npmfile is up-to-date."
  else
    cat $TMP_NPMFILE_PATH > $NPMFILE_PATH

    git add $NPMFILE_PATH && git -m "dot update npm" && git pull
    echo "Updated file npmfile."
  fi;
fi;
