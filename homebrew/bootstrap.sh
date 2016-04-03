#!/bin/sh

DOTFILES_ROOT="$(dirname "$(pwd -P)")"

sh ./install.sh

### Check if file Brewfile exist
###   if it exists, run "brew bundle"
###   if not exist, run "sh update.sh" to create update

if test -f ./Brewfile
then
  echo "Brewfile exists"
  brew bundle
else
  echo "Brewfile doens't exist"
  sh update.sh && brew bundle
fi
