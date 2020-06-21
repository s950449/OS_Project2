#!/bin/sh
END=10
#rm $PWD/output/5_$1_master_result.txt
for i in {1..10};
do
    $PWD/user_program/master 5 $1 $PWD/input/1K.img $PWD/input/5K.img $PWD/input/1M.img $PWD/input/10M.img $PWD/input/100M.img | grep "Transmission time" >> $PWD/output/zero_$1_master_result.txt
done
