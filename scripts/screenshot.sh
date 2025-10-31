#!/usr/bin/sh
tmp=$(mktemp)
grim -g "$(slurp)" $tmp  \
        && swappy -f $tmp

rm $tmp

