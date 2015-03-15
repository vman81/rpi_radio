#! /bin/bash
btn6=0
while [ $btn6 -eq 0 ]; do
btn1=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 40)
btn2=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 41)
btn3=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 42)
btn4=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 43)
btn5=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 44)
btn6=$(bw_tool  -I -D /dev/i2c-1 -a 94 -R 45)
echo "6: $btn6 - 5: $btn5 - 4: $btn4 - 3: $btn3 - 2: $btn2 - 1: $btn1"
sleep 0.2
clear
done
