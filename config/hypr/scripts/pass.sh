#!/bin/bash

STORE=~/.password-store
STORE_PREF='password-store'

FILES=$(fd -t f '^[a-zA-Z0-9]*\.gpg$' $STORE | sed -E "s/^.*$STORE_PREF\/([a-zA-Z0-9/]+)\.gpg/\1/g")
FILE=$(tofi <<< $FILES)

if [[ -n $FILE ]]; then
    pass show -c $FILE

    notify-send "Password $FILE is copied"
fi
