#!/bin/sh
END=10
#rm $PWD/output/5_$1_master_result.txt
for i in {1..10};
do
    $PWD/user_program/master 5 $1 $PWD/input/R1K.img $PWD/input/R5K.img $PWD/input/R1M.img $PWD/input/R10M.img $PWD/input/R100M.img | grep "Transmission time" >> $PWD/output/random_$1_master_result.txt
done

