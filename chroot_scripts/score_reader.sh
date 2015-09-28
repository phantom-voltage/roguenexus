#!/bin/bash

RAW_SCORE=/score/$1

old_IFS=$IFS      # save the field separator           
IFS=$'\n'     # new field separator, the end of line           

i=0
for line in $(cat $RAW_SCORE)          
do          
	i=$((i + 1 ))
	if [ "$1" == "BROG" -o "$1" == "BROG_CUR_COMP" ]
	then
		DATE=$(echo $line | cut -d' ' -f3)
		DATE=$(echo $(date -d @$DATE +"%m/%d/%Y"))
		line=$(echo -e "$(echo $line | cut -d' ' -f1)\t$(echo $line | cut -d' ' -f2) \t$DATE\t$(echo $line | cut -d' ' --complement -s -f1-3)")
	fi

	if [ "$1" == "ANG" -o "$1" == "PCB" ]
	then
		DISPLAY_SCORE=$(echo "$DISPLAY_SCORE""\n" $line)
	else
		DISPLAY_SCORE=$(echo "$DISPLAY_SCORE""\n""$i)" $line)
	fi
done          
IFS=$old_IFS     # restore default field separator 

OUT=$(echo -e "$DISPLAY_SCORE") 
case "$1" in
	"BROG" ) TITLE="Brogue";;
	"BROG_CUR_COMP") TITLE="Brogue Current Competition";;
	"BROG_OLD_COMP") TITLE="Brogue All-time Competition";;
	"ADOM" ) TITLE="ADOM";;
	"ANG" ) TITLE="Angband";;
	"PCB" ) TITLE="Poschengband";;
esac

dialog --title "$TITLE Scores" --msgbox "$OUT" 25 95
#dialog --title "$1 HIGHSCORES" --textbox "$RAW_SCORE" 25 90
