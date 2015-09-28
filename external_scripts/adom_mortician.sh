#!/usr/bin/env bash

DIR=/opt/dgamelaunch/cdda/dgldir/adom_data/last_ttyrec
LOG=/var/log/game_server/adom_mortician.log

inotifywait -r -m "$DIR" --format '%w%f' -e close_write |
while read file; do
	echo $file "closed for reading"
	sleep 1
	./adom_score_scrape.sh $file
done
