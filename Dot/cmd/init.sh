#!/bin/bash
# 1) Check if $HOME/dotfiles exists
# if so,
#   i)   Get the info for repo
#   ii)  Check if users have access right
# if not,
#   iii) Create the folder,
#   iv)  git init
#   v)   Ask user to create a repo and input the link
# 2) Create .dotinit with the info
# 3) Bundle and backup the dotfiles

echo "Dot/init"

init () {
  if [[ -n $DOT_TOPIC ]]; then
    run_command "init" $DOT_TOPIC;
  else
    all_topics | while read topic; do
      run_command "init" $topic;
    done
  fi;
}

init;
source "$DOT_DIRECTORY/cmd/bundle.sh";
