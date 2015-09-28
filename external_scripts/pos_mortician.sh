#!/usr/bin/env bash

DIR=/opt/dgamelaunch/cdda/dgldir/pos_data/lib/apex/
SCORE=/opt/dgamelaunch/cdda/score/POS
OLDSCORE=/opt/dgamelaunch/cdda/score/POS.old
OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in


inotifywait -m "$DIR" --format '%w%f' -e close_write |
while read file; do
	echo $file "closed for writing"
	./pos_autopsy.sh	
		
done
