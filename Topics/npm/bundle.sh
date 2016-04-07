#!/bin/sh
#
# .npmfile
#   Stores all npm global packages with responding versions
# init.sh
#   To make sure npm or node or iojs was installed
# install.sh
#   Sync the npm global packages based on .npmfile, regardless if .npmfiles is the latest version or not.
#   Will not remove installed global packages which is not on .npmfile.
# update.sh
#   Update the .npmfile based on npm global packages on the local machine.
#   Add and commit .npmfile.

source "$DOT_TOPIC_DIRECTORY/share.sh";

bundle () {
  pushd $DOT_TOPIC_DIRECTORY;

  if [ -f $NPMFILE_PATH ]; then
    sh install.sh
  else
    sh update.sh
    sh install.sh
  fi;

  popd;
}

bundle;
