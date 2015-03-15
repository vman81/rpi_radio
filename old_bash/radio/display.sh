#! /bin/bash
#sleep 1

echo "DISPLAY - args are:" $1 $2 

if [ "$1" == station ]; then
   #echo "test2"
   station=$(mpc -f [%name%] | sed -n 1p)
   echo "DISPLAY - Displaying current station $station"
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
   bw_tool  -I -D /dev/i2c-1 -a 94 -t "                "
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
   bw_tool  -I -D /dev/i2c-1 -a 94 -t "$station"
fi

if [ "$1" == artist_title ]; then
   title=$(mpc -f [%title%] | sed -n 1p)
   if [[ $title == *"Senest sp"* ]]
      then
      title=$(mpc -f [%title%] | sed -n 1p | cut -c 17-)
   fi
   if [ -n "$title" ]; then
     echo "DISPLAY - Displaying title - $title"
     bw_tool -I -D /dev/i2c-1 -a 94 -w 11:20
     bw_tool -I -D /dev/i2c-1 -a 94 -t "                 "
     bw_tool -I -D /dev/i2c-1 -a 94 -w 11:20
     bw_tool -I -D /dev/i2c-1 -a 94 -t "$title"
   fi
fi

if [ "$1" == clear ]; then
   echo "DISPLAY - clearing screen"
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 10:00
fi
if [ "$1" == contrast ]; then
   echo "DISPLAY - setting contrast to $2"
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 12:$2
fi
if [ "$1" == text1 ]; then
   echo "DISPLAY - Line 1 set to $2"
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
   bw_tool  -I -D /dev/i2c-1 -a 94 -t "                "
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
   bw_tool  -I -D /dev/i2c-1 -a 94 -t $2
fi
if [ "$1" == text2 ]; then
   echo "DISPLAY - Line 2 set to $2"
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:20
   bw_tool  -I -D /dev/i2c-1 -a 94 -t "                "
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:20
   bw_tool  -I -D /dev/i2c-1 -a 94 -t $2
fi
if [ "$1" == clear1 ]; then
   echo "DISPLAY - Clear line 1"
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
   bw_tool  -I -D /dev/i2c-1 -a 94 -t "                "
fi
if [ "$1" == clear2 ]; then
   echo "DISPLAY - Clear line 2"
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:20
   bw_tool  -I -D /dev/i2c-1 -a 94 -t "                "
fi
if [ "$1" == buttons ]; then
   echo "DISPLAY - reading used buttons - depricated"
   bw_tool -I -D /dev/i2c-1 -a 94 -R 30
fi
if [ "$1" == clear1later ]; then
   echo "DISPLAY - Clear line 1 in $2 seconds"
   sleep $2
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
   bw_tool  -I -D /dev/i2c-1 -a 94 -t "                "
fi
if [ "$1" == clear2later ]; then
   echo "DISPLAY - Clear line 2 in $2 seconds"
   sleep $2
   bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:20
   bw_tool  -I -D /dev/i2c-1 -a 94 -t "                "
fi


