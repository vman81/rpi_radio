#! /bin/bash
btn7=0
#fullline=0
bw_tool  -I -D /dev/i2c-1 -a 94 -w 10:00
bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
./display.sh station
./title_scroll.sh artist_title &
count=0
while [ $btn7 -eq 0 ]; do
btn1=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 40)
btn2=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 41)
btn3=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 42)
btn4=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 43)
btn5=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 44)
btn6=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 45)

if [ "$btn6" -eq 01 ]; then
sh ./radio.sh btn6
 while [ "$btn6" -eq 01 ]; do
  btn6=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 45)
 done
fi

if [ "$btn5" -eq 01 ]; then
sh ./radio.sh btn5
 while [ "$btn5" -eq 01 ]; do
  btn5=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 44)
 done
fi

if [ "$btn4" -eq 01 ]; then
sh ./radio.sh btn4
 while [ "$btn4" -eq 01 ]; do
  btn4=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 43)
 done
fi

if [ "$btn3" -eq 01 ]; then
sh ./radio.sh btn3
 while [ "$btn3" -eq 01 ]; do
  btn3=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 42)
 done
fi

if [ "$btn2" -eq 01 ]; then
sh ./radio.sh btn2
 while [ "$btn2" -eq 01 ]; do
  btn2=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 41)
 done
fi

if [ "$btn1" -eq 01 ]; then
sh ./radio.sh btn1
 while [ "$btn1" -eq 01 ]; do
  btn1=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 40)
 done
fi

done


