#!/bin/sh
#
# Using homebrew-bundle https://github.com/Homebrew/homebrew-bundle
#
# .brewfilerc
#   To serve as a config for brew.
# install.sh
#   To install homebrew based on the OS type.
# sync.sh
#   To sync the brew formulas based on Brewfile. Will not remove installed formulas which is not on Brewfile.
# update.sh
#   To update the Brewfile and commit if there is any change.
# cleanup.sh
#   To uninstall all Homebrew formulae not listed in Brewfile.

# DOTFILES_ROOT="$(dirname "$(pwd -P)")"

BREWFILE_PATH="$(pwd)/Brewfile";

sh install.sh;

if test -f $BREWFILE_PATH; then
  echo "Brewfile exists.";
  sh sync.sh;
else
  echo "Brewfile doens't exist.";
  sh update.sh && sh sync.sh;
fi
