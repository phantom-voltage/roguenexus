#!/usr/bin/env bash

DIR=/opt/dgamelaunch/cdda/dgldir/sil_data/lib/apex/
SCORE=/opt/dgamelaunch/cdda/score/SIL
OLDSCORE=/opt/dgamelaunch/cdda/score/.SIL.old


inotifywait -m "$DIR" --format '%w%f' -e close_write |
while read file; do
	echo $file "closed for writing"
	./sil_autopsy.sh	
		
done
