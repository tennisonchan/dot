#!/bin/bash
set +o posix

source "$DOT_TOPIC_DIRECTORY/share.sh";

update_Brewfile () {
  local brewfile_path=$1

  brew bundle dump --force --file="$brewfile_path";
  echo "Updated Brewfile.";
}

brew update
update_Brewfile $BREWFILE_PATH;
