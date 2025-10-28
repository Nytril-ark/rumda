#!/bin/bash
/home/${USER}/.config/rumda/scripts/wall.sh light && \
sleep 0.5

#launch quickshell directly and grab its PID
quickshell -p /home/${USER}/.config/rumda/common/quickshell/light/shell.qml & 
NEW_PID=$!
disown $NEW_PID

sleep 1

pgrep -af "quickshell -p" | awk -v pid="$NEW_PID" '$1 != pid { print $1 }' | xargs -r kill



