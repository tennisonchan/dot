#!/bin/bash
set +o posix

return_workplace_hash () {
  git rev-parse --verify --quiet $1
}

workplace_commands () {
  pushd $DOTFILES_DIRECTORY > /dev/null;

  local workplace_name=$1

  if [[ -n $workplace_name ]]; then
    local workplace_hash=$(return_workplace_hash $workplace_name)

    if [[ -n $workplace_hash ]]; then
      git stash > /dev/null;
      git checkout $workplace_name
    else
      git checkout -b $workplace_name
    fi;
  else
    git branch
  fi;

  popd > /dev/null;
}

config_commands () {
  case $2 in
    workplace)   workplace_commands $3;;
  esac
}

config_commands $@