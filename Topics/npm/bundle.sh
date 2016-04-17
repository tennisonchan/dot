#!/bin/sh
#
# Npmfile
#   Stores all npm global packages with responding versions
# init.sh
#   To make sure npm or node or iojs was installed
# install.sh
#   Sync the npm global packages based on Npmfile, regardless if Npmfiles is the latest version or not.
#   Will not remove installed global packages which is not on Npmfile.
# update.sh
#   Update the Npmfile based on npm global packages on the local machine.
#   Add and commit Npmfile.

echo "npm/bundle"

source "$DOT_TOPIC_DIRECTORY/share.sh";

bundle () {
  pushd $DOT_TOPIC_DIRECTORY > /dev/null

  if ! [[ -f $NPMFILE_PATH ]]; then
    source update.sh
  fi;

  source install.sh

  popd > /dev/null
}

bundle;
