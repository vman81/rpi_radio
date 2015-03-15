#! /bin/bash
if [ "$1" = btn6 ]; then
./display.sh clear
./display.sh text1 "Previous station"
mpc prev
./display.sh station
fi

if [ "$1" = btn5 ]; then
./display.sh clear                                                                                     │echo "args are:" $1 $2                                                                             
mpc load http://live-icy.gss.dr.dk/A/A03H.mp3.m3u
mpc load http://live-icy.gss.dr.dk/A/A04H.mp3.m3u
mpc load http://live-icy.gss.dr.dk/A/A05H.mp3.m3u
mpc load http://live-icy.gss.dr.dk/A/A06H.mp3.m3u
mpc play
./display.sh station
./title_scroll.sh artist_title &
fi

if [ "$1" = btn4 ]; then
mpc stop
mpc clear
./display.sh clear                                                                                     │echo "args are:" $1 $2                                                                             
./display.sh text1 "Stopped"
fi

if [ "$1" = btn3 ]; then
./display.sh clear                                                                                     │echo "args are:" $1 $2                                                                             
./display.sh text1 "Next station"
mpc next
sleep 1
./display.sh station
fi

if [ "$1" = btn2 ]; then
mpc volume +5
currentvolume=$(mpc | grep volume | cut -c2-12)
./display.sh text2 "V$currentvolume"
./display.sh clear2later 5 &
fi

if [ "$1" = btn1 ]; then
mpc volume -5
currentvolume=$(mpc | grep volume | cut -c2-12)
./display.sh text2 "V$currentvolume"                                                                             │   bw_tool  -I -D /dev/i2c-1 -a 94 -w 12:$2                                                        
./display.sh clear2later 5 &
fi
