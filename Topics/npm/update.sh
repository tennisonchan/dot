#!/bin/sh
#
#   Update the .npmfile based on npm global packages on the local machine.
#   Add and commit .npmfile.

echo "npm/update.sh";

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

update_dotfile () {
  local filename="$1";
  local ORIGINAL_FILE="$HOME/$filename";

  if [[ -f $ORIGINAL_FILE ]]; then
    cp $ORIGINAL_FILE $DOTFILES_DIRECTORY;
    add_filename_to_dotlist $ORIGINAL_FILE;
  fi;
}

update_dotfiles () {
  echo ".npmrc" | while read filename; do
    update_dotfile $filename;
  done
}

reset_dotlist;
create_npmfile;
update_dotfiles;
