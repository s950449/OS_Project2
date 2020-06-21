# OS Project 2
## Design
### Master Device(master_device.c)
### Slave Device(slave_device.c)
### Master User Program(master.c)
### Slave User Program(slave.c)
## Difference between file-I/O and memory-mapped I/O
### Sample_Input
#### File I/O(Slave)
* Sending 1 file per exeution
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
* Sending 10 file per execution
#### Memory-mapped I/O(Slave)
* Sending 1 file per exeution
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
### Self-designed-Input (Large files)
## 組內分工表
## Reference:
1. http://www.jollen.org/blog/2007/01/linux_virtual_memory_areas_vma.html
2. https://blog.csdn.net/eZiMu/article/details/54910019
3. https://stackoverflow.com/questions/5748492/is-there-any-api-for-determining-the-physical-address-from-virtual-address-in-li
4. https://www.kernel.org/doc/gorman/html/understand/understand006.html
5. http://www.jollen.org/blog/2007/04/mmap_remap_page_range_nutshell.html
6. https://github.com/paraka/mmap-kernel-transfer-data/