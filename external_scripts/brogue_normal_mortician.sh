#!/usr/bin/env bash

DIR=/opt/dgamelaunch/cdda/dgldir/brogue_data/normal

inotifywait -r -m "$DIR" --exclude '\.(swx|swp|broguesave|broguerec)' --format '%w%f' -e close_write |
    while read file; do
	echo $file "closed for writing"
	sleep 1
	./brogue_normal_score_scrape.sh $file
    done
