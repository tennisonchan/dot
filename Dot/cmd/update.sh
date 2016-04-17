#!/bin/bash
set +o posix

echo "Dot/update"

list_all_home_dotfiles () {
  find $HOME \( -type f \) -maxdepth 1 -mindepth 1 -name ".*" ! -name ".dotfiles" ! -name ".Trash" ! -name ".DS_Store"
}

update_topic () {
  if [[ -n $DOT_TOPIC ]]; then
    run_command "update" $DOT_TOPIC;
  else
    ls $DOT_TOPICS_DIRECTORY | while read topic; do
      set_topic "$topic";
      run_command "update" $topic;
    done
  fi;
}

update_dotfile () {
  local src=$1 dst="$DOTFILES_DIRECTORY/$dotfile" dotfile=$(basename "$src")
  local backup=
  local action=

  if [ $backup_all == "false" ] && [ $skip_all == "false" ]; then

    if [ $dst == $src ]; then
      backup=false;
    else
      echo "Do you want to copy file: $dotfile to dotfiles?\n\
      [y]es, [Y]es all, [s]kip, [S]kip all, [skip]?"
      read -n 1 -s action < /dev/tty

      case "$action" in
        y)
          backup=true;;
        Y)
          backup_all=true;;
        s)
          backup=false;;
        S)
          skip_all=true;;
        *)
          backup=false;;
      esac
    fi
  fi

  backup=${backup:-$backup_all}

  if [ $backup == "true" ]; then
    cp -ri $src $dst </dev/tty
    echo "copy $dotfile to dotfiles"
  else
    echo "skip $dotfile"
  fi
}

update_dotfiles () {
  local backup_all=false skip_all=false

  list_all_home_dotfiles | while read src; do
    update_dotfile $src;
  done
}

update_topic
update_dotfiles
