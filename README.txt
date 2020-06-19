This is the source code of operating system project2.

./master_device : the device moudule for master server
./slave_device  : the device moudule for slave client
./ksocket: the device moudule including the funtions used for kernel socket
./user_program : the user program "master" and "slave"


To use it, please:
1.change to super user
2.execute "./compile.sh" to compile codes and install modules
3.follow the input instrutions in the spec, 
i.e.
./master $num_of_files $method $file_name(s)
./slave $num_of_files $method $ip_addr $file_name(s)

Make sure that you are under the path "./user_program" when you execute user programs.
Though the execution order of user program "master" and "slave" does not matter,
it is suggested to execute "master" first to get more precise transmission time.

