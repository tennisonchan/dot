#!/bin/sh
#
#   To uninstall all Homebrew formulae not listed in Brewfile

brew_bundle_cleanup () {
  pushd $DOTFILES_DIRECTORY;

  brew bundle cleanup;

  popd;
}

brew_bundle_cleanup;
