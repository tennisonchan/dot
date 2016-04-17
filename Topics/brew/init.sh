#!/bin/sh
#
# To Install homebrew based on the OS type

# Check for Homebrew
check_for_brew () {
  if test $(which brew); then
    echo "Homebrew Installed";
    brew -v;
    brew update;
  else
    echo "Installing Homebrew for you.";

    # Install the correct homebrew for each OS type
    if test "$(uname)" = "Darwin"; then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)";
    fi;
  fi;
}

check_for_brew;
