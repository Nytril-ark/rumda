#!/bin/bash
/home/${USER}/.config/rumda/scripts/wall.sh dark && \
sleep 0.5

# CHANGED: launch quickshell directly (no outer subshell) and grab its PID
quickshell -p /home/${USER}/.config/rumda/dark-config/quickshell/shell.qml & 
NEW_PID=$!
disown $NEW_PID

# wait a bit to make sure it’s running
sleep 1

# CHANGED: only kill *other* quickshells, not this one
pgrep -af "quickshell -p" | awk -v pid="$NEW_PID" '$1 != pid { print $1 }' | xargs -r kill

