#!/bin/bash
set +o posix

echo "Dot/symlink"

list_all_dotfiles () {
  find $1 -maxdepth 1 -mindepth 1 -name ".*"
}

symlink_dotfiles () {
  echo 'Symlinking dotfiles'

  local from_dir=$1 to_dir=$2
  local overwrite_all=false backup_all=false skip_all=false

  pushd $from_dir > /dev/null;
  
  list_all_dotfiles $from_dir | while read src; do
    dst="$to_dir/$(basename $src)"
    link_file $src $dst
  done

  popd > /dev/null;
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]; then
        skip=true;
      else
        echo "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action < /dev/tty;

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      rm -rf "$dst"
      echo "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
      mv "$dst" "${dst}.backup"
      echo "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
      echo "skipped $src"
    fi
  fi

  # "false" or empty
  if [ "$skip" != "true" ]; then
    ln -s "$1" "$2"
    echo "linked $(basename $1) to HOME"
  fi
}

symlink_dotfiles $DOTFILES_DIRECTORY $HOME