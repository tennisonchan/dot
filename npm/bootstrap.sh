#!/bin/sh
#
# .npmfile:
#   Stores all npm global packages with responding versions
# sync.sh:
#   Sync the npm global packages based on .npmfile, regardless if .npmfiles is the latest version or not.
#   Will not remove installed global packages which is not on .npmfile.
# update.sh:
#   Update the .npmfile based on npm global packages on the local machine.
#   Add and commit .npmfile.

NPMFILE_PATH="$(pwd)/.npmfile"

if [ -f $NPMFILE_PATH ]; then
  sh sync.sh
then
  sh update.sh
  sh sync.sh
fi;
