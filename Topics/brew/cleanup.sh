#!/bin/sh
#
#   To uninstall all Homebrew formulae not listed in Brewfile

brew_bundle_cleanup () {
  pushd $DOTFILES_DIRECTORY > /dev/null;

  brew bundle cleanup;

  popd > /dev/null;
}

brew_bundle_cleanup;
