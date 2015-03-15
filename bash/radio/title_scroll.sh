#! /bin/bash

condition="1"
if [ "$1" == artist_title ]; then
   title=$(mpc -f [%title%] | sed -n 1p)
   if [[ $title == *"Senest sp"* ]]
      then
      title=$(mpc -f [%title%] | sed -n 1p | cut -c 17-)
   fi
   echo "TITLE_SCROLL - CHECK IF EMPTY"
   if [ -n "$title" ]; then
     echo "TITLE_SCROLL - Displaying title - $title"
     LEN=$(echo ${#title})
     if [ $LEN -lt 17 ]; then
        echo  "TITLE_SCROLL - Noscroll"
        bw_tool -I -D /dev/i2c-1 -a 94 -w 11:20
        bw_tool -I -D /dev/i2c-1 -a 94 -t "                 "
        bw_tool -I -D /dev/i2c-1 -a 94 -w 11:20
        bw_tool -I -D /dev/i2c-1 -a 94 -t "$title"
     else
        echo  "TITLE_SCROLL - scroll"
         while [ "$condition" == 1 ]; do
               newtitle=$(mpc -f [%title%] | sed -n 1p)
               if [[ $title == *"Senest sp"* ]]
                  then
                     newtitle=$(mpc -f [%title%] | sed -n 1p | cut -c 17-)
               fi
               if [[ $newtitle != *"$title"* ]]; then
                  condition="0"
               fi
               if [[ -z "$newtitle" ]]; then
                  condition="0"
               fi
               echo "condition $condition old and new title still match $title and $newtitle"
               sleep 1
               bw_tool -I -D /dev/i2c-1 -a 94 -w 11:20
               bw_tool -I -D /dev/i2c-1 -a 94 -t "                 "
               bw_tool -I -D /dev/i2c-1 -a 94 -w 11:20
               bw_tool -I -D /dev/i2c-1 -a 94 -t "longtitle"
         done
     fi   
   fi
   else
   echo "TITLE_SCROLL - empty string"
echo "TITLE_SCROLL - ends"
fi
