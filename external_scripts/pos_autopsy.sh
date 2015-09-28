#!/bin/bash

RAW=/opt/dgamelaunch/cdda/dgldir/pos_data/lib/apex/scores.raw
SCORE=/opt/dgamelaunch/cdda/score/PCB
#SCORE=ANG
OLDSCORE=/opt/dgamelaunch/cdda/score/.PCB_OLD
#OLDSCORE=ANG.old

OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in

echo $RAW
cp $SCORE $OLDSCORE

./pos_scores.py $RAW > $SCORE 
CHANGE=$(grep -Fxvf $OLDSCORE $SCORE | tail -n 1 | xargs)
echo "Change is $CHANGE"

if [ "$CHANGE" == "" ]
then
	echo "Not modified."
else

	MSG=$(cat $SCORE | grep "$CHANGE" -B2 | head -n 2 | tr '\n' ' ' | xargs | cut -c 1-)
	echo "PCB: $MSG" >> $OUT 
fi
