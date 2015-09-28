#!/bin/bash

RAW=/opt/dgamelaunch/cdda/dgldir/sil_data/lib/apex/scores.raw
#RAW=../test/sil.raw
#SCORE=SIL
SCORE=/opt/dgamelaunch/cdda/score/SIL
#OLDSCORE=.SIL_OLD
OLDSCORE=/opt/dgamelaunch/cdda/score/.SIL_OLD

OUT=/tmp/gitircbot/irc.freenode.net/"##roguenexus"/in

echo $RAW
cp $SCORE $OLDSCORE

./sil_scores.py $RAW > $SCORE 
CHANGE=$(grep -Fxvf $OLDSCORE $SCORE | tail -n 1 | xargs)
echo "Change is $CHANGE"

if [ "$CHANGE" == "" ]
then
	echo "Not modified."
else

	#MSG=$(cat $SCORE | grep "$CHANGE" -B2 | head -n 2 | tr '\n' ' ' | xargs -0 | cut -c 1-)
	MSG1=$(cat $SCORE | grep "$CHANGE" -B2 | head -n 1 )
	MSG2=$(cat $SCORE | grep "$CHANGE" -B2 | tail -n 2 | tr '\n' ' '| sed -e 's/ V //' | sed -e 's/\*//g' | xargs | rev | cut -c14- |rev | sed -e 's/^./\L&\E/' )
	echo "SIL: $MSG1 $MSG2." >> $OUT
fi
