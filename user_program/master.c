#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>
#include <stdlib.h>

#define FILE_START_NUM 3
#define BUF_SIZE 512
#define PAGE_SIZE 4096
#define P2_MAP_SIZE PAGE_SIZE * 100
size_t get_filesize(const char* filename);//get the size of the input file


int main (int argc, char* argv[])
{
	char buf[BUF_SIZE];
	int i, dev_fd, file_fd;// the fd for the device and the fd for the input file
	size_t ret, file_size, offset = 0, tmp;
	char file_name[50], method[20];
	char *kernel_address = NULL, *file_address = NULL;
	struct timeval start;
	struct timeval end;
	double trans_time; //calulate the time between the device is opened and it is closed
	i=atoi(argv[1]);
	strcpy(method,argv[2]);
	int file_start_num = FILE_START_NUM;
	if( (dev_fd = open("/dev/master_device", O_RDWR)) < 0)
	{
		perror("failed to open /dev/master_device\n");
		return 1;
	}
	for(int j = 0;j < i; j++){
		offset = 0;
		ret = 0;
		memset(file_name,0,sizeof(file_name));
		strcpy(file_name,argv[file_start_num + j]);
		gettimeofday(&start ,NULL);
		if( (file_fd = open (file_name, O_RDWR)) < 0 )
		{
			perror("failed to open input file\n");
			return 1;
		}

		if( (file_size = get_filesize(file_name)) < 0)
		{
			perror("failed to get filesize\n");
			return 1;
		}


		if(ioctl(dev_fd, 0x12345677) == -1) //0x12345677 : create socket and accept the connection from the slave
		{
			perror("ioclt server create socket error\n");
			return 1;
		}


		switch(method[0])
		{
			case 'f': //fcntl : read()/write()
				do
				{
					ret = read(file_fd, buf, sizeof(buf)); // read from the input file
					write(dev_fd, buf, ret);//write to the the device
				}while(ret > 0);
				break;
			case 'm'://mmap
				while(offset<file_size){
					size_t len = P2_MAP_SIZE;
					if((file_size - offset )<len){
						len = file_size - offset;
					}
					printf("Debug\n");
					printf("len %d\n",len);
					file_address = mmap(NULL,len,PROT_READ,MAP_SHARED,file_fd,offset);
					printf("Debug2\n");
					kernel_address = mmap(NULL,len,PROT_WRITE,MAP_SHARED,dev_fd,offset);
					printf("Debug3\n");
					printf("%s\n",file_address);
					printf("%s\n",kernel_address);
					memcpy(kernel_address,file_address,len);
					offset += len;
					ioctl(dev_fd,0x12345678,len);
				}
				break;
		}
		ioctl(dev_fd,0x1234);
		if(ioctl(dev_fd, 0x12345679) == -1) // end sending data, close the connection
		{
			perror("ioclt server exits error\n");
			return 1;
		}
		gettimeofday(&end, NULL);
		trans_time = (end.tv_sec - start.tv_sec)*1000 + (end.tv_usec - start.tv_usec)*0.0001;
		printf("Transmission time: %lf ms, File size: %d bytes\n", trans_time, file_size / 8);

		close(file_fd);
	}
	close(dev_fd);

	return 0;
}

size_t get_filesize(const char* filename)
{
    struct stat st;
    stat(filename, &st);
    return st.st_size;
}
