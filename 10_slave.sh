#!/bin/sh
IP="127.0.0.1"
END=10
#rm $PWD/output/5_$1_slave_result.txt
for i in {1..10};
do
    $PWD/user_program/slave 10 $1 $IP $PWD/output/target_file_1 $PWD/output/target_file_2 $PWD/output/target_file_3 $PWD/output/target_file_4 $PWD/output/target_file_5  $PWD/output/target_file_6 $PWD/output/target_file_7 $PWD/output/target_file_8 $PWD/output/target_file_9 $PWD/output/target_file_10  | grep "Transmission time" >> $PWD/output/10_$1_slave_result.txt
done
