#!/bin/bash

OUT="/tmp/gitircbot/irc.freenode.net/##roguenexus/out"
#OUT="/tmp/gitircbot/irc.freenode.net/#gohoubi/out"
IN="/tmp/gitircbot/irc.freenode.net/##roguenexus/in"
#IN="/tmp/gitircbot/irc.freenode.net/#gohoubi/in"

NICK="<Eyebotv2>"
MORGUE=/home/game_server/morgue/cemetery/list

inotifywait -m "$OUT" --format '%w%f' -e modify |
    while read file; do

MSG=`tail -1 $OUT` 

if   echo $MSG | grep -Fvq $NICK 
	then
	if  echo $MSG | grep -Fq '!online' 
	then

			INFO=`sudo /opt/dgamelaunch/cdda/dgamelaunch -s`

			if [ "$INFO" == "" ]
			then
				echo "No players online." >> $IN
			else

			CURDATE=$(date -u)
			CURTIME=$(date -u -d "$CURDATE" +%s)

			OLD_IFS=$IFS
			IFS=$'\n'
			set -f
			foo=($INFO)

			MORE=""

			for a in "${foo[@]}"
			do
				STARTTIME=""
				STARTDATE=""

				STARTDATE=$(echo $a | awk -F"#" '{print $4}')
				STARTTIME=$(date -u -d"$STARTDATE" +%s)
				DIFF=$((CURTIME-STARTTIME))
				PLAYTIME=$(date -u -d @"$DIFF" +'%-Hh %-Mm')

				MORE=$(echo $MORE && echo $a | awk -F"#" '{print $1}' && echo $a | awk -F"#" '{print $2}' && echo $PLAYTIME",")

			done
			IFS=$OLD_IFS

			echo ${MORE::-1} >> $IN
			fi

	elif echo $MSG | grep -Fq '!help' 
		then echo "Possible commands: !help, !online, !recent" >> $IN
		#then echo "Possible commands: !help, !online, !more, !recent" 


	elif echo $MSG | grep -Fq '!recent' 
		then RECENT=`cat $MORGUE | tail -2`
	#	echo $RECENT 
		echo $RECENT >> $IN 
	fi
fi

sleep 1

done

