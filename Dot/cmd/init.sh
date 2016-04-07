#!/bin/bash
# Reset the dotfiles
# Bundle and backup the dotfiles

reset_dotfiles () {
  if [[ -n $DOT_TOPIC_DIRECTORY ]]; then
    cat "$DOT_TOPIC_DIRECTORY/.dotlist" | while read file; do
      echo "remove $DOTFILES_DIRECTORY/$file";
      if [[ -f $DOTFILES_DIRECTORY/$file ]]; then
        rm -f $DOTFILES_DIRECTORY/$file;
      fi;
    done
  else
    rm -rf $DOTFILES_DIRECTORY;
    mkdir $DOTFILES_DIRECTORY;
  fi;
}

main () {
  reset_dotfiles;
  if [[ -f "$DOT_TOPIC_DIRECTORY/init.sh" ]]; then
    sh "$DOT_TOPIC_DIRECTORY/init.sh";
  fi;
  sh "$DOT_DIRECTORY/cmd/bundle.sh";
}

echo "Sure you want to reset all dotfiles?";
select yn in "Yes" "No"; do
  case $yn in
    Yes) main; break;;
    No)  exit;;
  esac
done
