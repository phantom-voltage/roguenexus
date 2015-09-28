#!/usr/bin/env bash

DIR=/opt/dgamelaunch/cdda/dgldir/ang_data/lib/scores
SCORE=/opt/dgamelaunch/cdda/score/ANG
OLDSCORE=/opt/dgamelaunch/cdda/score/ANG.old
OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in


inotifywait -m "$DIR" --format '%w%f' -e close_write |
while read file; do
	echo $file "closed for writing"
	test=$(basename $file)

	if [ "$test" == "scores.lok" ]
	then
		./ang_autopsy.sh	
		
		
	fi
done
