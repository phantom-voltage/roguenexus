#!/bin/bash

IN=$1
#USER=$1
#CMD=$2
#GAME=$3
USER=`echo $IN | cut -d '_' -f 1`
CMD=`echo $IN | cut -d '_' -f 2`
GAME=`echo $IN | cut -d '_' -f 3`
DIR=/dgldir/userdata/$USER

if [ "$GAME" == "ADOM_R59" ]
then
	GAME=ADOM
elif [ "$GAME" == "ANGs" ]
then
	GAME=ANG
fi

TIME=$(date +%s)

if [ "$CMD" == "end" ]
then
	
	DATA=$(tac "$DIR/$USER.log")
	
	old_IFS=$IFS
	IFS=$'\n'

	for LINE in $DATA
	do
	#	echo "LINE is $LINE"
	
		DATA_CMD=$(echo $LINE | cut -d ' ' -f 1)
		DATA_GAME=$(echo $LINE | cut -d ' ' -f 2)
		
	#	echo $DATA_CMD
		#echo $DATA_GAME

		if [ "$DATA_GAME" == "$GAME" ]
		then
			if [ "$DATA_CMD" == "start" ]
			then
				#echo "$DATA_GAME MATCHES $GAME"
				DATA_TIME=$(echo $LINE | cut -d ' ' -f 3)
				TIMER=$(( $TIME - $DATA_TIME ))
			#	echo $TIMER
#				((h=${TIMER}/3600))
 #				((m=(${TIMER}%3600)/60))
 #				((s=${TIMER}%60))
#				printf "%02d:%02d:%02d\n" $h $m $s
				/bin/update_profile.sh $USER $GAME $TIMER
				GAME="NONE"
			fi
		fi
	done
	> "$DIR/$USER.log"

else
	echo "$CMD $GAME $TIME" >> "$DIR/$USER.log"

fi

IFS=$old_IFS
##call formatter##
