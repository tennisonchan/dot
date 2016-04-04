#!/bin/sh
#
# To Install homebrew based on the OS type

# Check for Homebrew
if test ! $(which brew); then

  echo " Installing Homebrew for you.";

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)";
  fi;

else
  echo " Homebrew Installed";
fi;

exit 0;
