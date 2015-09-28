#!/bin/bash

ERROR=error.log

shutdown() 
{
	echo $OLDROWS $OLDCOLS >>$ERROR
	stty rows $OLDROWS cols $OLDCOLS
	# Get our process group id
	PGID=$(ps -o pgid= $$ | grep -o [0-9]*)

	# Kill it in a new new process group
	kill -SIGKILL $PGID
	setsid kill -- -$PGID
	exit 0
}

trap "shutdown 2>>$ERROR" EXIT SIGINT SIGTERM SIGHUP

#NEWROWS=25
#NEWCOLS=80

#OLDSIZE=$(stty size)
#OLDROWS=`echo $OLDSIZE | cut -d' ' -f1`
#OLDCOLS=`echo $OLDSIZE | cut -d' ' -f2`

#echo "size before change" $(stty size) >> dgldir/adom_memorial/sizeout

#stty rows $NEWROWS cols $NEWCOLS

#echo "size after change" $(stty size) >> dgldir/adom_memorial/sizeout

##if [ ! -f ~/config/$1.cfg ]
##then
##	cp /dgldir/templates/adom_r59/adom.cfg /dgldir/adom_r59_data/config/$1.cfg 
##	echo "Name = $1" >> /dgldir/adom_r59_data/config/$1.cfg

##fi

CFG_CHECK=$(head -n 1 ~/.adom.data/adom.cfg)

if [ "$CFG_CHECK" != "# DO NOT CHANGE: [Configuration file version 1]" ]
then
#	echo "$CFG_CHECK does not equal # DO NOT CHANGE: [Configuration file version 1]"
#	sleep 2
	cp /dgldir/templates/adom_r60/adom.cfg ~/.adom.data/adom.cfg
	echo "Name = $1" >> ~/.adom.data/adom.cfg
fi

#CHECK=$(cat ~/.adom.data/adom.cfg | tail -n 1)

#if [ "$CHECK" != "Name = $1" ]
#then
#	echo "Metric_Measuring = true" >> ~/.adom.data/adom.cfg
#	echo "Name = $1"
#fi



cd dgldir/adom_data/memorial
COLUMNS=80 LINES=25 exec /games/adom_r60/adom_r60

#trap 'jobs -p | xargs kill' EXIT
#stty cols 104 rows 39 
#echo "size after adom $(stty size)" >> sizeout
