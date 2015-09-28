#!/bin/bash

#COMP_LIST=/opt/dgamelaunch/cdda/brogue/competition_list
COMP_LIST=/home/game_server/game_scripts/competition_list
#CUR_COMP=/opt/dgamelaunch/cdda/score/BROG_CUR_COMP
CUR_COMP=/home/game_server/game_scripts/BROG_CUR_COMP
#OLD_COMP=/opt/dgamelaunch/cdda/score/BROG_OLD_COMP
OLD_COMP=/home/game_server/game_scripts/BROG_OLD_COMP

COMP_DATA=$(cat $COMP_LIST | tail -1)

COMP_NUM=$(echo $COMP_DATA | cut -d' ' -f1)
COMP_SEED=$(echo $COMP_DATA | cut -d' ' -f2)


cat $COMP_LIST
cat $CUR_COMP

echo $COMP_NUM
echo $COMP_SEED


NEW_COMP_SEED=$(shuf -i 1-4294967295 -n 1)
NEW_COMP_NUM=$((COMP_NUM + 1))


echo $NEW_COMP_NUM
echo $NEW_COMP_SEED

echo "---------------------BROGUE-WEEK-$COMP_NUM-COMPETITION----------------------" >> $OLD_COMP
echo "----------------------------SEED-$COMP_SEED--------------------------------" >> $OLD_COMP
cat $CUR_COMP >> $OLD_COMP

mv $CUR_COMP /home/game_server/game_scripts/.BROG_COMP_BACKUP_$COMP_NUM
touch $CUR_COMP
echo "$NEW_COMP_NUM $NEW_COMP_SEED" >> $COMP_LIST

