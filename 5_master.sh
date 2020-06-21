#!/bin/sh
END=10
#rm $PWD/output/5_$1_master_result.txt
for i in {1..10};
do
    $PWD/user_program/master 5 $1 $PWD/input/sample_input_1/target_file_6 $PWD/input/sample_input_1/target_file_7 $PWD/input/sample_input_1/target_file_8 $PWD/input/sample_input_1/target_file_9 $PWD/input/sample_input_1/target_file_10 | grep "Transmission time" >> $PWD/output/5_$1_master_result.txt
done

