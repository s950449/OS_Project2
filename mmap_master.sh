#!/bin/sh
END=10
rm $PWD/output/mmap_master_result.txt
for i in $(seq 1 $END);
do
    $PWD/user_program/master 1 mmap $PWD/input/sample_input_1/target_file_$i | grep "Transmission time" >> $PWD/output/mmap_master_result.txt
done
