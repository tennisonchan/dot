# !/bin/sh
#
#   Sync the npm global packages based on Npmfile, regardless if Npmfiles is the latest version or not.
#   Will not remove installed global packages which is not on Npmfile.

source "$DOT_TOPIC_DIRECTORY/share.sh";

if [[ -f $NPMFILE_PATH ]]; then
  cat $NPMFILE_PATH | while read line; do
    echo "Installing npm global packages $line"
    npm install -g $line
  done
else
  echo "Missing file Npmfile. Please run 'dot update npm'."
fi;
