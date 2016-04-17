#!/bin/bash

source "$DOT_TOPIC_DIRECTORY/share.sh";

update_Brewfile () {
  pushd $DOTFILES_DIRECTORY > /dev/null;

  rm -f "./Brewfile";
  brew bundle dump;

  echo "Updated Brewfile.";
  popd > /dev/null;
}

update_Brewfile;
