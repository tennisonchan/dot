# !/bin/sh
set +o posix

check_for_node () {
  if test $(which node); then
    echo "npm installed";
    npm version;
    npm update;
  else
    echo "Installing node for you.";
    message=$(brew install node 2>&1);

    if [[ "$message" == *"not linked" ]]; then
      brew link node
    fi;
  fi;
}

check_for_node
source "$DOT_TOPIC_DIRECTORY/bundle.sh";
