#!/bin/sh
set +o posix

check_if_brew_installed () {
  if test $(which brew); then
    echo "Homebrew Installed";
    brew -v;
    brew update;
  else
    echo "Installing Homebrew for you.";

    if test "$(uname)" = "Darwin"; then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)";
    fi;

    brew tap Homebrew/bundle
  fi;
}

check_if_brew_installed;
source "$DOT_TOPIC_DIRECTORY/bundle.sh";
