#! /bin/bash
btn7=0
fullline=0
bw_tool  -I -D /dev/i2c-1 -a 94 -w 10:00
bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
count=0
while [ $btn7 -eq 0 ]; do
btn1=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 40)
btn2=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 41)
btn3=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 42)
btn4=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 43)
btn5=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 44)
btn6=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 45)
if [ "$btn1" -eq 01 ]; then
bw_tool  -I -D /dev/i2c-1 -a 94 -t "1"
echo 1
((count=count+1))
echo $count
sleep 0.3
fi
if [ "$btn2" -eq 01 ]; then
bw_tool  -I -D /dev/i2c-1 -a 94 -t "2"
echo 2
((count=count+1))
echo $count
sleep 0.3
fi
if [ "$btn3" -eq 01 ]; then
bw_tool  -I -D /dev/i2c-1 -a 94 -t "3"
echo 3
((count=count+1))
echo $count
sleep 0.3
fi
if [ "$btn4" -eq 01 ]; then
bw_tool  -I -D /dev/i2c-1 -a 94 -t "4"
echo 4
((count=count+1))
echo $count
sleep 0.3
fi
if [ "$btn5" -eq 01 ]; then
bw_tool  -I -D /dev/i2c-1 -a 94 -t "5"
echo 5
((count=count+1))
echo $count
sleep 0.3
fi
if [ "$btn6" -eq 01 ]; then
bw_tool  -I -D /dev/i2c-1 -a 94 -t "6"
echo 6 - RESET
#((count=count+1))
echo $count
#sleep 0.3
bw_tool  -I -D /dev/i2c-1 -a 94 -w 10:00
bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
count=0
fi
if [ "$count" -eq 16 ]; then
bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:20
fi
if [ "$count" -eq 32 ]; then
bw_tool  -I -D /dev/i2c-1 -a 94 -w 11:00
((count=0))
fi




#echo "6: $btn6 - 5: $btn5 - 4: $btn4 - 3: $btn3 - 2: $btn2 - 1: $btn1"
#sleep 0.2
#clear
done


