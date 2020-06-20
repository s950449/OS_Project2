#!/bin/sh
END=10
for i in $(seq 1 $END);
do
    $PWD/user_program/master 1 fcntl $PWD/input/sample_input_1/target_file_$i | grep "Transmission time" >> $PWD/output/fcntl_master_result.txt
done
