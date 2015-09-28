#!/bin/bash

RAW=/opt/dgamelaunch/cdda/dgldir/ang_data/lib/scores/scores.raw
SCORE=/opt/dgamelaunch/cdda/score/ANG
#SCORE=ANG
OLDSCORE=/opt/dgamelaunch/cdda/score/.ANG_OLD
#OLDSCORE=ANG.old

OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in

cp $SCORE $OLDSCORE

./scores.py $RAW > $SCORE 
CHANGE=$(grep -Fxvf $OLDSCORE $SCORE | tail -n 1 | xargs )
echo "Change is $CHANGE"

MSG=$(cat $SCORE | grep "$CHANGE" -B2 | head -n 2 | tr '\n' '.' | xargs | cut -c 1-)
echo "ANG: $MSG" >> $OUT
