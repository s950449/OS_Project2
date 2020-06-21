# OS Project 2
## Design
### Master Device(master_device.c)
Design master_device file_operations and mmap_operations:

```
void project2_open(struct vm_area_struct *vma)
void project2_close(struct vm_area_struct *vma)
static int project2_fault(struct vm_fault *vmf)
static const struct vm_operations_struct project2_vm_ops = {
	.open = project2_open,
	.close = project2_close,
	.fault = project2_fault
};
static int project2_mmap(struct file *file,struct vm_area_struct *vma){
```
In `project2_open` and `project2_close`, just print debug message or do nothing.
In `project2_fault`, deal with page fault.
In `project2_mmap`, use `virt_to_phys` and `remap_pfn_range` to handle memory mapping.
Design master_ioctl_mmap operations: Use `ksend` to send data to socket.
### Slave Device(slave_device.c)
Design master_device file_operations and mmap_operations:
```
void project2_open(struct vm_area_struct *vma){
}
void project2_close(struct vm_area_struct *vma){
}
static int project2_fault(struct vm_fault *vmf){
}
static const struct vm_operations_struct project2_vm_ops = {
	.open = project2_open,
	.close = project2_close,
	.fault = project2_fault
};
static int project2_mmap(struct file *file,struct vm_area_struct *vma){
}
```
In `project2_open` and `project2_close`, just print debug message or do nothing.
In `project2_fault`, deal with page fault.
In `project2_mmap`, use `virt_to_phys` and `remap_pfn_range` to handle memory mapping.
Design slave_ioctl_mmap operations:
* Use `krecv` with `MSG_WAITALL` flag to get data,`MSG_WAITALL` should block until all data from socket has been received.  Copy data to file. If data_size >= P2_MAP_SIZE: return
### Master User Program(master.c)
Input Parameter: ./master num_of_files method file(s)
`Example: ./master 1 mmap test.txt`
Step by Step:
1. 使用一個迴圈來依序傳送輸入的檔案
1.1. 使用Sample Code 的fcntl傳送:直接使用原本的sample code
1.2. 使用mmap接收:一次最多傳送P2_MAP_SIZE大小的檔案內容至master_device，並重複此步驟至該檔案傳送完畢
2. 迴圈結束後印出其執行時間及檔案大小
### Slave User Program(slave.c)
Input Parameter: ./slave num_of_files method IP file(s)
`Example: ./slave 3 fcntl 127.0.0.1 test.txt test2.txt test3.txt`
1. 使用一個迴圈來依序接收檔案
1.1. 使用Sample Code 的fcntl接收:使用原本的sample code
1.2. 使用mmap接收:持續從slave_device讀取資料，並重複此步驟至所有資料讀取完畢(ret=0)
2. 迴圈結束後印出其執行時間及檔案大小
## Page Descriptor
![](https://i.imgur.com/ZBguksr.png)
## Difference between file-I/O and memory-mapped I/O
為了方便比較，統一使用slave的output(因為master的有手動操作延遲的問題)
### Sample_Output
#### File I/O(Slave)
* Sending 1 file per exeution(target_file 1~10 and target_file)
```
Transmission time: 0.165000 ms, File size: 4 bytes
Transmission time: 0.085700 ms, File size: 107 bytes
Transmission time: 0.121700 ms, File size: 167 bytes
Transmission time: 0.066900 ms, File size: 207 bytes
Transmission time: 0.091500 ms, File size: 255 bytes
Transmission time: 0.084000 ms, File size: 383 bytes
Transmission time: 0.055100 ms, File size: 351 bytes
Transmission time: 0.056600 ms, File size: 507 bytes
Transmission time: 0.044300 ms, File size: 457 bytes
Transmission time: 0.058700 ms, File size: 577 bytes
Transmission time: 8.604500 ms, File size: 1502860 bytes
```
* Sending 5 file per execution
Output of `./5_slave.sh fcntl`
```
Transmission time: 0.306000 ms, File size: 2275 bytes
Transmission time: 0.369900 ms, File size: 2275 bytes
Transmission time: 0.240400 ms, File size: 2275 bytes
Transmission time: 0.239800 ms, File size: 2275 bytes
Transmission time: 0.327300 ms, File size: 2275 bytes
Transmission time: 0.425900 ms, File size: 2275 bytes
Transmission time: 0.320200 ms, File size: 2275 bytes
Transmission time: 0.375800 ms, File size: 2275 bytes
Transmission time: 0.270000 ms, File size: 2275 bytes
Transmission time: 0.352500 ms, File size: 2275 bytes
```
Average time: 0.320008 ms
* Sending 10 file per execution
Output of `./10_slave.sh fcntl`
```
Transmission time: 0.505900 ms, File size: 3018 bytes
Transmission time: 0.528700 ms, File size: 3018 bytes
Transmission time: 0.562100 ms, File size: 3018 bytes
Transmission time: 0.556900 ms, File size: 3018 bytes
Transmission time: 0.572800 ms, File size: 3018 bytes
Transmission time: 0.527900 ms, File size: 3018 bytes
Transmission time: 0.486800 ms, File size: 3018 bytes
Transmission time: 0.493300 ms, File size: 3018 bytes
Transmission time: 0.488000 ms, File size: 3018 bytes
Transmission time: 0.388300 ms, File size: 3018 bytes
```
Average Time: 0.51107 ms
#### Memory-mapped I/O(Slave)
* Sending 1 file per exeution(target_file 1~10 and target_file)
```
Transmission time: 0.501900 ms, File size: 4 bytes
Transmission time: 0.078600 ms, File size: 107 bytes
Transmission time: 0.096500 ms, File size: 167 bytes
Transmission time: 0.196100 ms, File size: 207 bytes
Transmission time: 0.069900 ms, File size: 255 bytes
Transmission time: 0.080000 ms, File size: 383 bytes
Transmission time: 0.057000 ms, File size: 351 bytes
Transmission time: 0.062800 ms, File size: 507 bytes
Transmission time: 0.048000 ms, File size: 457 bytes
Transmission time: 0.169500 ms, File size: 577 bytes
Transmission time: 2.693700 ms, File size: 1502860 bytes
```
* Sending 5 file per execution
Output of `./5_slave.sh mmap`
```
Transmission time: 0.289900 ms, File size: 2275 bytes
Transmission time: 0.244300 ms, File size: 2275 bytes
Transmission time: 0.306400 ms, File size: 2275 bytes
Transmission time: 0.219100 ms, File size: 2275 bytes
Transmission time: 0.232500 ms, File size: 2275 bytes
Transmission time: 0.273700 ms, File size: 2275 bytes
Transmission time: 0.308200 ms, File size: 2275 bytes
Transmission time: 0.522400 ms, File size: 2275 bytes
Transmission time: 0.346200 ms, File size: 2275 bytes
Transmission time: 0.335200 ms, File size: 2275 bytes
Transmission time: 0.183800 ms, File size: 2275 bytes
Transmission time: 0.366400 ms, File size: 2275 bytes
Transmission time: 0.248100 ms, File size: 2275 bytes
```
Average time:0.298169231 ms
* Sending 10 file per execution
Output of `./10_slave.sh mmap`
```
Transmission time: 0.358500 ms, File size: 3018 bytes
Transmission time: 0.307200 ms, File size: 3018 bytes
Transmission time: 0.395400 ms, File size: 3018 bytes
Transmission time: 0.484600 ms, File size: 3018 bytes
Transmission time: 0.332700 ms, File size: 3018 bytes
Transmission time: 0.431600 ms, File size: 3018 bytes
Transmission time: 0.379500 ms, File size: 3018 bytes
Transmission time: 0.500100 ms, File size: 3018 bytes
Transmission time: 0.521000 ms, File size: 3018 bytes
Transmission time: 0.436200 ms, File size: 3018 bytes
```
Average Time: 0.41468 ms
### Self-designed-Input (Large files)
Use dd to generate two sets of image files:
1. ` dd bs=1M count=100 if=/dev/zero of=./input/100M.img`
2. ` dd bs=1 count=100M if=/dev/random of=./input/R100M.img`
We have 5 different size:1K,5K,1M,10M,100M.
Use `md5sum` or `sha512sum` to check the integrity of file.
Example:`sudo sha512sum output/R10M.img input/R10M.img`
Note:for *.img files,use `git lfs` instead.(More info :https://git-lfs.github.com/)
```
89a3d69233efd946c57b7a62cc300d50254cf1d7e5cb380960a328a197f462fec9e4c4ef7284ed74ea61333606ae09ec26c5322a4d1fc05f06cabcae41541d54  output/R10M.img
89a3d69233efd946c57b7a62cc300d50254cf1d7e5cb380960a328a197f462fec9e4c4ef7284ed74ea61333606ae09ec26c5322a4d1fc05f06cabcae41541d54  input/R10M.img
```
## 組內分工表
## Reference:
1. http://www.jollen.org/blog/2007/01/linux_virtual_memory_areas_vma.html
2. https://blog.csdn.net/eZiMu/article/details/54910019
3. https://stackoverflow.com/questions/5748492/is-there-any-api-for-determining-the-physical-address-from-virtual-address-in-li
4. https://www.kernel.org/doc/gorman/html/understand/understand006.html
5. http://www.jollen.org/blog/2007/04/mmap_remap_page_range_nutshell.html
6. https://github.com/paraka/mmap-kernel-transfer-data/
7. https://stackoverflow.com/questions/8470403/socket-recv-hang-on-large-message-with-msg-waitall