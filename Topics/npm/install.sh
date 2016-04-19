# !/bin/sh
set +o posix

source "$DOT_TOPIC_DIRECTORY/share.sh";

get_package_with_versions () {
  cat $1 | grep "from" | awk -F "\"" '{print $4}'
}

install_npm_packages () {
  local npmfile=$1
  if [[ -f $npmfile ]]; then
    get_package_with_versions $npmfile | while read line; do
      echo "Installing npm global packages $line"
      npm install -g $line
    done
  else
    echo "Missing file Npmfile. Please run 'dot backup npm'"
  fi;
}

install_npm_packages $NPMFILE_PATH
