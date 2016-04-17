#!/bin/bash
set +o posix

DOT_VERSION="0.0.1"

git_clone_dotfiles_repo () {
  pushd "$HOME" > /dev/null
  git clone $1 $DOTFILES_DIRECTORY > /dev/null
  popd > /dev/null
}

check_dotfiles_folder () {
  if ! [[ -d $DOTFILES_DIRECTORY ]]; then
    echo "Missing the $DOTFILES_DIRECTORY folder.";
    echo "Please paste your dotfiles repo link here: "
    echo "(example: https://github.com/[username]/dotfiles.git)";

    read DOTFILES_REPO < /dev/tty
    if [[ -n $DOTFILES_REPO ]]; then
      git_clone_dotfiles_repo $DOTFILES_REPO
    fi
  fi;
}

load_config() {
  source "$DOT_DIRECTORY/config"
}

commands () {
  DOT_ARG_COUNT="$#"
  case "$1" in
    init)        DOT_COMMAND="init";;
    bundle)      DOT_COMMAND="bundle";;
    install)     DOT_COMMAND="install";;
    i)           DOT_COMMAND="install";;
    up)          DOT_COMMAND="update";;
    update)      DOT_COMMAND="update";;
    ln)          DOT_COMMAND="symlink";;
    link)        DOT_COMMAND="symlink";;
    symlink)     DOT_COMMAND="symlink";;
    unlink)      DOT_COMMAND="unlink";;
    config)      DOT_COMMAND="config";;
    --config)    DOT_COMMAND="config";;
    help)        DOT_COMMAND="help";;
    -h)          DOT_COMMAND="help";;
    --help)      DOT_COMMAND="help";;
    *)           DOT_COMMAND="help";;
  esac

  if [[ -f "$DOT_DIRECTORY/cmd/$DOT_COMMAND.sh" ]]; then
    DOT_BASH_COMMAND_FILE="$DOT_DIRECTORY/cmd/$DOT_COMMAND.sh"
  fi
}

set_topic () {
  if [[ -n $1 ]] && [[ -d "$DOT_TOPICS_DIRECTORY/$1" ]]; then
    DOT_TOPIC="$1"
    DOT_TOPIC_DIRECTORY="$DOT_TOPICS_DIRECTORY/$1"
  fi;
}

run_command () {
  local command=$1
  local topic=$2
  if [[ -f "$DOT_TOPICS_DIRECTORY/$topic/$command.sh" ]]; then
    source "$DOT_TOPICS_DIRECTORY/$topic/$command.sh"
  fi;
}

all_topics () {
  ls $DOT_TOPICS_DIRECTORY
}

check_dotfiles_folder
load_config
commands $@
set_topic $2

if [[ -n "$DOT_BASH_COMMAND_FILE" ]]; then
  source "$DOT_BASH_COMMAND_FILE"
fi;
