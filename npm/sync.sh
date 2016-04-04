# !/bin/sh
#
#   Sync the npm global packages based on .npmfile, regardless if .npmfiles is the latest version or not.
#   Will not remove installed global packages which is not on .npmfile.

NPMFILE_PATH="$(pwd)/.npmfile"

if [ -f $NPMFILE_PATH ]; then
  cat $NPMFILE_PATH | while read line; do
    echo "Installing npm global packages $line"
    npm install -g $line
  done
else
  echo "Missing file .npmfile. Please run 'dot update npm'."
fi;
