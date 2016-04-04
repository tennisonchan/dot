#!/bin/sh
#
#   To sync the brew formulas based on Brewfile. Will not remove installed formulas which is not on Brewfile.

BREWFILE_PATH="$(pwd)/Brewfile";

if test -f $BREWFILE_PATH; then
  brew bundle install;
else
  echo "Missing file Brewfile. Please run 'dot update npm'.";
fi;
