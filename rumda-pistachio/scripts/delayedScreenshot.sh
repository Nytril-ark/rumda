#!/usr/bin/sh

echo "toggle" > /tmp/qs-dashboard.fifo 

sleep 0.8

tmp=$(mktemp)
grim -g "$(slurp)" $tmp  \
        && swappy -f $tmp

rm $tmp

