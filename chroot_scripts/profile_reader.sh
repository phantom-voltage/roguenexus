#!/bin/bash
USER=$1
RAW_PROFILE=/dgldir/userdata/$USER/$USER.prf

old_IFS=$IFS      # save the field separator           
IFS=$'\n'     # new field separator, the end of line           

PROFILE="Playtime\n"

if ! [ -a $RAW_PROFILE ]
then
	PROFILE="No playtime recorded yet.\nTry playing some games now!\n"
else

for line in $(cat $RAW_PROFILE)          
do          
	GAME=$(echo $line | cut -d' ' -f1)

	if [ "$GAME" == "BROG-COMP" ]
	then
		GAME="BRCO"
	fi

	TIMER=$(echo $line | cut -d' ' -f2)
	
	((h=${TIMER}/3600))
	((m=${TIMER}/60))
	((s=${TIMER}%60))
	TIME=$(printf "%dh %dm %ds\n" $h $m $s)
	
	PROFILE=$(echo "$PROFILE""\n\n"$GAME"\t" $TIME)

	

done          
IFS=$old_IFS     # restore default field separator 
fi

OUT=$(echo -e "$PROFILE") 

dialog --title "$USER Profile" --no-collapse --msgbox "$OUT" 25 95
#dialog --title "$1 HIGHSCORES" --textbox "$RAW_SCORE" 25 90
