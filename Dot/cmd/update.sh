#!/bin/bash
set +o posix

list_all_home_dotfiles () {
  find $1 \( -type f \) -maxdepth 1 -mindepth 1 -name ".*" ! -name ".dotfiles" ! -name ".Trash" ! -name ".DS_Store"
}

update_topic () {
  local topic_dir=$1 topic=$2
  if [[ -n $topic ]]; then
    run_command "update" $topic;
  else
    ls $topic_dir | while read topic; do
      set_topic $topic;
      run_command "update" $topic;
    done
  fi;
}

update_dotfile () {
  local src=$1 dst=$2 dotfile=$3
  local update= action=

  if [ $update_all == "false" ] && [ $skip_all == "false" ]; then

    if [ $dst == $src ]; then
      update=false;
    else
      echo "Do you want to move file: $dotfile to dotfiles?\n\
      [y]es, [Y]es all, [s]kip, [S]kip all?"
      read -n 1 action < /dev/tty

      case $action in
        y)
          update=true;;
        Y)
          update_all=true;;
        s)
          update=false;;
        S)
          skip_all=true;;
        *)
          update=false;;
      esac
    fi
  fi

  update=${update:-$update_all}

  if [ $update == "true" ]; then
    mv -i $src $dst < /dev/tty
    echo "move $dotfile to dotfiles"
  else
    echo "skip $dotfile"
  fi
}

update_dotfiles () {
  local update_all=false skip_all=false
  local from_dir=$1 to_dir=$2

  list_all_home_dotfiles $to_dir| while read src; do
    dotfile=$(basename $src)
    dst="$from_dir/$dotfile"
    update_dotfile $src $dst $dotfile;
  done
}

git_stash_dotfiles_change() {
  pushd $DOTFILES_DIRECTORY > /dev/null

  git stash;

  popd > /dev/null
}

git_commit_push () {
  pushd $DOTFILES_DIRECTORY > /dev/null

  git add .
  git commit -m "dot update on $(date)"
  git push -u origin

  popd > /dev/null
}

git_stash_dotfiles_change
update_topic $DOT_TOPICS_DIRECTORY $DOT_TOPIC
update_dotfiles $DOTFILES_DIRECTORY $HOME
git_commit_push
