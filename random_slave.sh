#!/bin/sh
IP="127.0.0.1"
END=10
#rm $PWD/output/5_$1_slave_result.txt
for i in {1..10};
do
    $PWD/user_program/slave 5 $1 $IP $PWD/output/R1K.img $PWD/output/R5K.img $PWD/output/R1M.img $PWD/output/R10M.img $PWD/output/R100M.img  | grep "Transmission time" >> $PWD/output/random_$1_slave_result.txt
done
