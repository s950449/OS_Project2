#!/bin/sh
IP="127.0.0.1"
END=10
#rm $PWD/output/5_$1_slave_result.txt
for i in {1..10};
do
    $PWD/user_program/slave 5 $1 $IP $PWD/output/1K.img $PWD/output/5K.img $PWD/output/1M.img $PWD/output/10M.img $PWD/output/100M.img  | grep "Transmission time" >> $PWD/output/zero_$1_slave_result.txt
done
