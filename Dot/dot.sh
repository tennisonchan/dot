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

commands () {
  DOT_ARG_COUNT="$#"
  DOT_COMMAND="$1"
  shift
  case "$DOT_COMMAND" in
    ln)          DOT_COMMAND="symlink";;
    link)        DOT_COMMAND="symlink";;
    symlink)     DOT_COMMAND="symlink";;
    up)          DOT_COMMAND="update";;
    update)      DOT_COMMAND="update";;
    install)     DOT_COMMAND="install";;

    ls)          DOT_COMMAND="list";;
    environment) DOT_COMMAND="--env";;
    --config)    DOT_COMMAND="config";;
  esac

  if [[ -f "$DOT_DIRECTORY/cmd/$DOT_COMMAND.sh" ]]; then
    DOT_BASH_COMMAND="$DOT_DIRECTORY/cmd/$DOT_COMMAND.sh"
  fi
}

set_topic () {
  if [[ -n $1 ]] && [[ -d "$DOT_TOPICS_DIRECTORY/$1" ]]; then
    DOT_TOPIC="$1"
    DOT_TOPIC_DIRECTORY="$DOT_TOPICS_DIRECTORY/$1"
    DOTLIST_PATH="$DOT_TOPIC_DIRECTORY/.dotlist";
  fi;
}

commands $@
set_topic $2

if [[ -n "$DOT_BASH_COMMAND" ]]; then
  source "$DOT_BASH_COMMAND"
fi;
