#!/bin/sh
#
#   To update the Brewfile and commit if there is any change.

BREWFILE_PATH="$(pwd)/Brewfile";

rm -f $BREWFILE_PATH;
brew bundle dump;

echo "Updated Brewfile.";
