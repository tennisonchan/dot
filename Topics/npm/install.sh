# !/bin/sh
set +o posix

source "$DOT_TOPIC_DIRECTORY/share.sh";

install_npm_packages () {
  if [[ -f $NPMFILE_PATH ]]; then
    cat $NPMFILE_PATH | while read line; do
      echo "Installing npm global packages $line"
      npm install -g $line
    done
  else
    echo "Missing file Npmfile. Please run 'dot update npm'."
  fi;
}

install_npm_packages
