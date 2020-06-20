#!/bin/sh
IP="127.0.0.1"
END=10
for i in $(seq 1 $END);
do
    $PWD/user_program/slave 1 fcntl $IP $PWD/output/target_file_$i
done