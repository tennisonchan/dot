#!/bin/sh
#
# Using homebrew-bundle https://github.com/Homebrew/homebrew-bundle
#
# .brewfilerc
#   To serve as a config for brew.
# init.sh
#   To install homebrew based on the OS type.
# install.sh
#   To sync the brew formulas based on Brewfile. Will not remove installed formulas which is not on Brewfile.
# update.sh
#   To update the Brewfile and commit if there is any change.
# cleanup.sh
#   To uninstall all Homebrew formulae not listed in Brewfile.

source "$DOT_TOPIC_DIRECTORY/share.sh";

source "$DOT_TOPIC_DIRECTORY/update.sh";
source "$DOT_TOPIC_DIRECTORY/install.sh";
