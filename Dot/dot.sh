#!/bin/bash
set +o posix

DOT_VERSION="0.0.1"

# is_OSX () {
#   if [[ "$(uname -s)" = "Darwin" ]]; then
#     DOT_OSX="1"
#   fi;
# }
#
# force_locale () {
#   # Force UTF-8 to avoid encoding issues for users with broken locale settings.
#   if [[ "$(locale charmap 2> /dev/null)" != "UTF-8" ]]; then
#     export LC_ALL="en_US.UTF-8"
#   fi
# }

load_config() {
  source "$DOT_DIRECTORY/config"

  if [[ -d "$HOME/dotfiles" ]]; then
    DOTFILES_DIRECTORY="$HOME/dotfiles";
  else
    echo "You are missing the $HOME/dotfiles folder";
  fi;
}

commands () {
  DOT_ARG_COUNT="$#"
  DOT_COMMAND="$1"
  case "$DOT_COMMAND" in
    ln)          DOT_COMMAND="symlink";;
    link)        DOT_COMMAND="symlink";;
    symlink)     DOT_COMMAND="symlink";;
    up)          DOT_COMMAND="update";;
    update)      DOT_COMMAND="update";;
    install)     DOT_COMMAND="install";;
    config)      DOT_COMMAND="config";;
    --config)    DOT_COMMAND="config";;

    ls)          DOT_COMMAND="list";;
    list)          DOT_COMMAND="list";;
  esac

  if [[ -f "$DOT_DIRECTORY/cmd/$DOT_COMMAND.sh" ]]; then
    DOT_BASH_COMMAND_FILE="$DOT_DIRECTORY/cmd/$DOT_COMMAND.sh"
  fi
}

set_topic () {
  if [[ -n $1 ]] && [[ -d "$DOT_TOPICS_DIRECTORY/$1" ]]; then
    DOT_TOPIC="$1"
    DOT_TOPIC_DIRECTORY="$DOT_TOPICS_DIRECTORY/$1"
    DOTLIST_PATH="$DOT_TOPIC_DIRECTORY/.dotlist";
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

load_config
commands $@
set_topic $2

if [[ -n "$DOT_BASH_COMMAND_FILE" ]]; then
  source "$DOT_BASH_COMMAND_FILE"
fi;
