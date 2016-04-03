#!/bin/sh

# Update Brewfile

BREWLISTFILE="$(pwd)/.brewlist"
BREWLIST=$(brew list -1)

if [ -f $BREWLISTFILE ] && [ "$BREWLIST" == "$(cat $BREWLISTFILE)" ]; then
  echo "brewlist is up-to-date."
else
  echo "${BREWLIST}" > $BREWLISTFILE
  echo "Updated file brewlist."
fi;

####

CASKLISTFILE="$(pwd)/.casklist"
CASKLIST=$(brew cask list -1)

if [ -f $CASKLISTFILE ] && [ "$CASKLIST" == "$(cat $CASKLISTFILE)" ]; then
  echo "casklist is up-to-date."
else
  echo "${CASKLIST}" > $CASKLISTFILE
  echo "Updated file casklist."
fi;

####

TAPLISTFILE="$(pwd)/.taplist"
TAPLIST=$(brew tap -1)

if [ -f $TAPLISTFILE ] && [ "$TAPLIST" == "$(cat $TAPLISTFILE)" ]; then
  echo "taplist is up-to-date."
else
  echo "${TAPLIST}" > $TAPLISTFILE
  echo "Updated file taplist."
fi;

####

OUTPUT="/tmp/.brewfile"
cat ".brewfile" > "/tmp/.brewfile"

cat $TAPLISTFILE | while read line ; do
  echo "tap '$line'"
done >> $OUTPUT

cat $BREWLISTFILE | while read line ; do
  echo "brew '$line'"
done >> $OUTPUT

cat $CASKLISTFILE | while read line ; do
  echo "cask '$line'"
done >> $OUTPUT

cat $OUTPUT > "./Brewfile"
