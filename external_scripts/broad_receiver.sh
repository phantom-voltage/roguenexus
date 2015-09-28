#!/usr/bin/env bash

MSG=/opt/dgamelaunch/cdda/chat/server_messages
OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in

OLD_TEXT=""

inotifywait -m "$MSG" --format '%w%f' -e close_write |
    while read file; do

	#echo $(cat $MSG | tail -1) >> $OUT
	TEXT=$(echo $(cat $MSG | tail -1))
	echo $TEXT	
	echo $OLD_TEXT
	if [ "$TEXT" != "$OLD_TEXT" ]
	then
		echo "$TEXT doesn't match $OLD_TEXT"
		echo "$TEXT" >> $OUT
	else
		echo "$TEXT matches $OLD_TEXT"
	fi	
	OLD_TEXT="$TEXT"
	
	
    done
