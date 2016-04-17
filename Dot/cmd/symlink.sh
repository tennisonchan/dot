#!/bin/bash
set +o posix

list_all_dotfiles () {
  find $1 -maxdepth 1 -mindepth 1 -name ".*" ! -name ".git"
}

symlink_dotfiles () {
  echo "Symlinking dotfiles"

  local src_dir=$1 dst_dir=$2
  local overwrite_all=false skip_all=false

  pushd $src_dir > /dev/null;

  list_all_dotfiles $src_dir | while read src; do
    dst="$dst_dir/$(basename $src)"
    link_file $src $dst
  done

  popd > /dev/null;
}

link_file () {
  local src=$1 dst=$2

  local overwrite= skip=
  local action=

  if [ -f $dst -o -d $dst -o -L $dst ]; then

    if [ "$overwrite_all" == "false" ] && [ "$skip_all" == "false" ]; then
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]; then
        skip=true;
      else
        echo "Symlink file already exists, $(basename $src), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all?"
        read -n 1 action < /dev/tty;

        case $action in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            skip=true;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      rm -rf $dst
      echo "removed $dst"
    fi

    if [ "$skip" == "true" ]; then
      echo "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]; then
    ln -s $src $dst
    echo "linked $(basename $src) to HOME"
  fi
}

symlink_dotfiles $DOTFILES_DIRECTORY $HOME