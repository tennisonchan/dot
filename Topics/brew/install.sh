#!/bin/sh
#
#   To sync the brew formulas based on Brewfile. Will not remove installed formulas which is not on Brewfile.

source "$DOT_TOPIC_DIRECTORY/share.sh";

install () {
  pushd "$DOTFILES_DIRECTORY" > /dev/null;

  if test -f $BREWFILE_PATH; then
    brew bundle install;
  else
    echo "Missing file Brewfile. Please run 'dot update brew'.";
  fi;

  popd > /dev/null;
}

install
