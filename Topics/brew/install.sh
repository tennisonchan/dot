#!/bin/sh
set +o posix

source "$DOT_TOPIC_DIRECTORY/share.sh";

install_brew_formulas () {
  local brewfile_path=$1

  if ! [[ -f $brewfile_path ]]; then
    brew bundle install --file="$brewfile_path";
  else
    echo "Missing file Brewfile. Please run 'dot update brew'." 1>&2;
  fi;
}

install_brew_formulas $BREWFILE_PATH;
