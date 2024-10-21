#!/bin/bash

FILENAME="$(date '+%Y-%m-%d_%H-%m-%S-%N.png')"
FILEPATH="$HOME/Pictures/Screenshots/$FILENAME"
MESSAGE_CLIP="Screenshot is taken"
MESSAGE_FILE="Screenshot is taken: $FILENAME"

SRC_SCREEN=0
SRC_SELECT=1
DST_FILE=0
DST_CLIP=1

SRC=$SRC_SCREEN
DST=$DST_FILE

for arg in "$@"
do
    case $arg in
        "--select" | "-s") SRC=$SRC_SELECT;;
        "--clip" | "-c") DST=$DST_CLIP;;
        *)
            echo No args;;
    esac
done

if [[ $SRC -eq $SRC_SCREEN && $DST -eq $DST_FILE ]]; then
    grim -t png -l 0 - > $FILEPATH

    notify-send "$MESSAGE_FILE"
elif [[ $SRC -eq $SRC_SELECT && $DST -eq $DST_FILE ]]; then
    grim -t png -l 0 -g "$(slurp)" - > $FILEPATH

    notify-send "$MESSAGE_FILE"
elif [[ $SRC -eq $SRC_SCREEN && $DST -eq $DST_CLIP ]]; then
    grim -t png -l 0 - | wl-copy

    notify-send "$MESSAGE_CLIP"
elif [[ $SRC -eq $SRC_SELECT && $DST -eq $DST_CLIP ]]; then
    grim -t png -l 0 -g "$(slurp)" - | wl-copy

    notify-send "$MESSAGE_CLIP"
fi
