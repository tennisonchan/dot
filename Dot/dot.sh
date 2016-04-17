#!/bin/bash
set +o posix

DOT_VERSION="0.1.0"

check_dotfiles_folder () {
  local dotfiles_dir=$1
  local status=$?

  if ! [[ -d $dotfiles_dir ]]; then
    echo "Missing the $dotfiles_dir folder." 1>&2
    echo "Please paste your dotfiles repo link here: "
    echo "(example: git@github.com:[username]/dotfiles.git)"

    read dotfiles_repo < /dev/tty
    if [[ -n $dotfiles_repo ]]; then
      git clone $dotfiles_repo $dotfiles_dir > /dev/null
      status=$?
    else
      status="1"
    fi
  fi;

  if ! [[ "$status" == "0" ]]; then
    exit 1;
  fi
}

load_config() {
  WORKPLACE=$(cd $DOTFILES_DIRECTORY && git symbolic-ref --short HEAD);
}

commands () {
  DOT_ARG_COUNT=$#
  case $1 in
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
    DOT_TOPIC=$1
    DOT_TOPIC_DIRECTORY="$DOT_TOPICS_DIRECTORY/$1"
  fi;
}

run_command () {
  local command=$1 topic=$2
  if [[ -f "$DOT_TOPICS_DIRECTORY/$topic/$command.sh" ]]; then
    set_topic $topic;
    source "$DOT_TOPICS_DIRECTORY/$topic/$command.sh";
  fi;
}

all_topics () {
  ls $DOT_TOPICS_DIRECTORY
}

check_dotfiles_folder $DOTFILES_DIRECTORY
load_config
commands $@
set_topic $2

if [[ -n $DOT_BASH_COMMAND_FILE ]]; then
  source $DOT_BASH_COMMAND_FILE
fi;
