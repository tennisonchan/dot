#!/bin/bash
set +o posix

list_all_home_dotfiles () {
  find $1 \( -type f \) -maxdepth 1 -mindepth 1 -name ".*" ! -name ".dotfiles" ! -name ".Trash" ! -name ".DS_Store" ! -name ".*history"
}

backup_on_topic () {
  local topic=$1
  if [[ -n $topic ]]; then
    run_command "backup" $topic;
  fi;
}

backup_dotfile () {
  local src=$1 dst=$2
  local dotfile="$(basename $src)"
  local backup= action=

  if [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

    if [ "$dst" == "$src" ]; then
      backup=false;
    else
      echo "Do you want to move file: $dotfile to dotfiles?\n\
      [y]es, [Y]es all, [s]kip, [S]kip all?"
      read -n 1 action < /dev/tty

      case $action in
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

  if [ "$backup" == "true" ]; then
    mv -i $src $dst < /dev/tty
    echo "move $dotfile to dotfiles"
  else
    echo "skip $dotfile"
  fi
}

backup_dotfiles () {
  local backup_all=false skip_all=false
  local from_dir=$1 to_dir=$2

  list_all_home_dotfiles $to_dir| while read src; do
    dst="$from_dir/$dotfile"
    backup_dotfile $src $dst $dotfile;
  done
}

git_stash_dotfiles_change() {
  pushd $DOTFILES_DIRECTORY > /dev/null

  if ! git diff-files --quiet --ignore-submodules; then
    echo "cannot push the backup: you have unstaged changes" 1>&2
    git diff-files --name-status -r --ignore-submodules 1>&2

    echo "stash your unstaged changes? [y/n]"
    read -n 1 action

    if [[ "$action" == "y" ]]; then
      git stash
    else
      exit 1;
    fi
  fi

  popd > /dev/null
}

git_commit_push () {
  pushd $DOTFILES_DIRECTORY > /dev/null

  git add .
  git commit -m "[$WORKPLACE] dot backup on $(date)"
  git push -u origin $WORKPLACE

  popd > /dev/null
}

git_stash_dotfiles_change
backup_on_topic $DOT_TOPIC
if ! [[ -n $DOT_TOPIC ]]; then
  backup_dotfiles $DOTFILES_DIRECTORY $HOME
fi;
git_commit_push
