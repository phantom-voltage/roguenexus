#!/usr/bin/env bash

OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in
DIR=/opt/dgamelaunch/cdda/dgldir/tsl_data/memorial

inotifywait -r -m "$DIR" --format '%w%f' -e close_write |
while read file; do
	echo $file "closed for reading"
	sleep 1
	MSG=$(cat $file | head -n 4 | tail -n 2 | tr '\n' ' ')
	echo "TSL: $MSG" >> $OUT
	unset MSG
done
