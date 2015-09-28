#!/bin/bash

# configuration
cd ii
path=/tmp/gitircbot # where the files created by ii go
server='irc.freenode.net'
#channel='#gohoubi'
channel='##roguenexus'
bot_pseudo='Eyebotv2'
bot_realname='Eyebotv2'

# launch the bot
while true
do
    # connect to the IRC server
    ./ii -s "$server" -i "$path" -n "$bot_pseudo" -f "$bot_realname" &
    pid="$!"
    # connect to the IRC channel
    sleep 5
    echo "/j $channel" > "$path/$server/in"
    echo "identify hentaiforhotdogs" > $path/$server/nickserv/in
    # if the bot disconnects, go back to square one
    wait "$pid"
done
