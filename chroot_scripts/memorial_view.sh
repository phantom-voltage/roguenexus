#!/bin/bash

function parse()
{
	cd $1
	i= FILES=()
	for a in *
	do
		if [ ${a: -4} == "$2" ]
		then
			FILES[i++]=`echo $a`
			FILES[i++]=""
		fi
	done


}

function notparse()
{
	cd $1
	i= FILES=()
	for a in *
	do

		if [ ${#a} -lt "4" ]
		then
			FILES[i++]=`echo $a`
			FILES[i++]=""

		elif [ ${a: -4} != "$2" ]
		then
		
			FILES[i++]=`echo $a`
			FILES[i++]=""
		fi
	done


}

function display()
{

	RESPONSE=0
	while [ $RESPONSE == 0 ]
	do	
		CHOICE=$(dialog --backtitle "R O G U E  N E X U S" \
		--ok-label "VIEW" --cancel-label "EXIT" --menu  "$1" \
		 20 50 15 "${FILES[@]}"  3>&1 1>&2 2>&3)
		RESPONSE=$?
		CHECK=$RESPONSE
	
		if [ $CHECK == 0 ]
		then
			dialog --clear --backtitle "R O G U E  N E X U S" \
			--title "$1" --textbox $CHOICE 40 80
		fi
	done


}

if [ "$1" == "ADOM" ]
	then
	parse dgldir/adom_data/memorial .flg
	display "ADOM MEMORIAL"

elif [ "$1" == "ADOM-SSH" ]
	then
	parse dgldir/adom_data/memorial .ssh
	display "ADOM SCREENSHOTS"

elif [ "$1" == "CDDA" ]
	then
	parse dgldir/cdda_data/cdda_memorial .txt
	display "CDDA MEMORIAL"

elif [ "$1" == "ANG" ]
	then
	parse dgldir/ang_data/Angband .txt
	display "ANGBAND MEMORIAL"

elif [ "$1" == "PCB" ]
	then
	notparse dgldir/pos_data/lib/user .prf
	display "POSCHENGBAND MEMORIAL"

elif [ "$1" == "TSL" ]
	then
	parse dgldir/tsl_data/memorial .txt
	display "THE SLIMY LICHMUMMY MEMORIAL"


fi

