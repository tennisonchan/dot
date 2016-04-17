#!/bin/sh
#
#   Update the Npmfile based on npm global packages on the local machine.
#   Add and commit Npmfile.

source "$DOT_TOPIC_DIRECTORY/share.sh";

reset_dotlist () {
  cp /dev/null $DOTLIST_PATH;
}

add_filename_to_dotlist () {
  local filename="${1##*/}"
  echo $filename >> $DOTLIST_PATH;
}

create_npmfile () {
  if [ -f $NPMLIST_FILE_PATH ] && [ "$NPMLIST" == "$(cat $NPMLIST_FILE_PATH)" ]; then
    echo "npmfile is up-to-date."
  else
    ls -1 $NPM_ROOT_PATH > $NPMLIST_FILE_PATH

    cat $NPMLIST_FILE_PATH | while read package; do
      echo "$package@$(npm info $package version)"
    done > $NPMFILE_PATH

    add_filename_to_dotlist $NPMFILE_PATH;
    echo "Updated file Npmfile."
  fi;
}

reset_dotlist;
create_npmfile;
