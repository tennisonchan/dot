#!/bin/sh
set +o posix

source "$DOT_TOPIC_DIRECTORY/share.sh";

brew_bundle_cleanup () {
  local brewfile_path=$1
  brew bundle cleanup --file="$brewfile_path";
}

brew_bundle_cleanup $BREWFILE_PATH;
