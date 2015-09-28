#!/bin/bash

TEMP=$$.temp

SCORE=/opt/dgamelaunch/cdda/score/ADOM
OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in

OLD_IFS=$IFS
IFS=$'\r'

NAME=$(basename $1)
#echo $NAME
TESTOUT=$(strings $1 | grep -i "$NAME" -A6 | grep '*' -A6)
#echo $TESTOUT


#echo $TESTOUT


while read line
do
	LINE1="$(echo $line | grep -i "$NAME\.")$(echo $LINE1)"
	#LINE2="$(echo $line | grep "2015")$(echo $LINE2)"
	LINE2="$(echo $line | grep -P '/[^/]*$')$(echo $LINE2)"
	LINE3="$(echo $line | grep "He\|She")$(echo $LINE3)"
	

	if [ "$LINE1" != "" -a "$LINE2" != "" -a "$LINE3" != "" ]
	then
		LINE1=$(echo $LINE1 | cut -c9- )
		LINE2=$(echo $LINE2 | cut -c4- )
		LINE3=$(echo $LINE3 | cut -c4- )
		
		COMPLETE=$(echo $LINE3 | grep -ci "\.")
		echo "COMPLETE is $COMPLETE"
		if [ $COMPLETE == 0 ]
		then
			read line
			read line
			LINE4=$(echo $line | cut -c4-)
		fi
			
		ENTRY=$(echo $LINE1 $LINE2 $LINE3 $LINE4 | xargs)
		
		if [ "$ENTRY" != "$OLD_ENTRY" ]
		then
			
			cat $SCORE > $TEMP
			echo $ENTRY >> $TEMP 
			echo "ADOM: $ENTRY" >> $OUT
			echo $ENTRY 

			cat $TEMP | sort --version-sort -r > $SCORE
			rm $TEMP
		fi
		
		unset LINE1
		unset LINE2
		unset LINE3
		unset LINE4
		
		#echo $
		#echo $LINE1 $LINE2 $LINE3 | xargs  >> ADOM
		OLD_ENTRY=$(echo $ENTRY)
		
	fi
	#echo "LOOP"

done< <(echo $TESTOUT)

IFS=$OLD_IFS
