#!/bin/sh
#
#   To update the Brewfile and commit if there is any change.

BREWFILE_PATH="$(pwd)/Brewfile";

rm -f $BREWFILE_PATH;
brew bundle dump;

git add $BREWFILE_PATH && git commit -m "dot update brew" && git pull;

echo "Updated Brewfile.";
