#!/bin/bash
set +o posix

echo "Dot/unlink"

list_all_linked_dotfiles () {
  find $1 -type l -maxdepth 1 -mindepth 1 -name ".*"
}

unlink_dotfiles () {
  echo "Unlinking dotfiles"

  local home_dir=$1
  local unlink_all=false

  pushd $home_dir > /dev/null;

  list_all_linked_dotfiles $home_dir | while read src; do
    unlink_file $src
  done

  popd > /dev/null;
}

unlink_file () {
  local src=$1

  local unlink=
  local action=

  if [[ $unlink_all == "false" ]]; then

    echo "Sure you want to unlink $(basename "$src")?\n\
    [y]es, [Y]es All, [s]kip, [S]kip all?"
    read -n 1 action < /dev/tty;

    case $action in
      y )
        unlink=true;;
      Y )
        unlink_all=true;;
      s )
        unlink=false;;
      S )
        unlink_all=false;;
      * )
        ;;
    esac
  fi

  unlink=${unlink:-$unlink_all}

  if [ $unlink == "true" ]; then
    unlink $src
    echo "unlinked $(basename $src)"
  fi
}

unlink_dotfiles $HOME