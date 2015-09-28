#!/bin/bash

SCORE_FILE_RAW=/opt/dgamelaunch/cdda/score/BROG
OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in
NEW=1
COPY=0
TEMP=.brogue_norm_score_temp

while read line; do
	NEW=1	
	if [ $( echo $line | cut -d' ' -f1) != 0 ]
	then
		
		echo "first while iterated"
		SCORE_CHECK=$(echo $line)
		#echo $SCORE_CHECK
		#cat $SCORE_FILE_RAW
		while read line2; do
			
			#echo "something found"
			if [ "$SCORE_CHECK" == "$line2" ]
			then
				echo "$SCORE_CHECK matches $line2"
				NEW=0
				
			fi
		done< <(cat $SCORE_FILE_RAW)
		
		echo "DINGNEW is $NEW"
		if [ "$NEW" == 1 ]
		then
			COPY=1
			#DATE=$(echo $SCORE_CHECK | cut -d' ' -f3)
			#DATE=$(echo $(date -d @$DATE +"%m/%d/%Y"))
			#SCORE_CHECK=$(echo "$(echo $SCORE_CHECK | cut -d' ' -f1-2) $DATE $(echo $SCORE_CHECK | cut -d' ' --complement -s -f1-3)")
			echo $SCORE_CHECK >> $SCORE_FILE_RAW
			echo $SCORE_CHECK
			FORMATTED_SCORE="$(echo $SCORE_CHECK | cut -d' ' -f1-2) $(echo $SCORE_CHECK | cut -d' ' -f1-3 --complement)"
			echo "Brogue: $FORMATTED_SCORE" >> $OUT

		fi
	
		
	
	fi
done< <(cat $1)

if [ $COPY == 1 ]
then
	echo "COPY is true."
	cat $SCORE_FILE_RAW >> $TEMP
	cat $TEMP | sort --version-sort -r > $SCORE_FILE_RAW
	rm $TEMP
fi

