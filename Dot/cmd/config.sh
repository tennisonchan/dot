#!/bin/bash
# To set a new workplace, if workplace does not exist yet
# dot config workplace [new workplace name]

# To set the workplace as current workflow, if workplace exists
# dot config workplace [exists workplace name]

# To return all the workplaces
# dot config workplace

echo "Dot/config"

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