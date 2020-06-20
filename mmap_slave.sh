#!/bin/sh
IP="127.0.0.1"
END=10
rm $PWD/output/mmap_slave_result.txt
for i in $(seq 1 $END);
do
    $PWD/user_program/slave 1 mmap $IP $PWD/received/target_file_$i | grep "Transmission time" >> $PWD/output/mmap_slave_result.txt
done
