#!/bin/bash

source "$DOT_TOPIC_DIRECTORY/share.sh";

reset_dotlist () {
  cp /dev/null $DOTLIST_PATH;
}

add_filename_to_dotlist () {
  local filename="${1##*/}"
  echo $filename >> $DOTLIST_PATH;
}

update_Brewfile () {
  pushd $DOTFILES_DIRECTORY > /dev/null;

  rm -f "./Brewfile";
  brew bundle dump;
  add_filename_to_dotlist "Brewfile"

  echo "Updated Brewfile.";
  popd > /dev/null;
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
  echo ".brewfilerc" | while read filename; do
    update_dotfile $filename;
  done
}

reset_dotlist;
update_Brewfile;
update_dotfiles;
