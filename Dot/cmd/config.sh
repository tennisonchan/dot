#!/bin/bash
set +o posix

return_workplace_hash () {
  git rev-parse --verify --quiet $1
}

workplace_commands () {
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
}

config_commands () {
  pushd $DOTFILES_DIRECTORY > /dev/null;

  shift
  case $1 in
    workplace)   workplace_commands $2;;
  esac

  popd > /dev/null;
}

config_commands $@