# Tasks Performed
## How to increase EC2 instance storage size(EBS Volume)?
1. Open the EC2 console
2. In the navigation pane, choose Instances, and the select the instance for which you want to increase the storage.
3. Choose the Storage tab, and select the volume OR In navigation pane, under Elastic Block Store choose Volumes and select the volume by the name.
4. From Actions, choose Modify Volume.
5. Under Volume details, enter the Size and IOPS based on the volume type.
6. Choose Modify, and then Modify in the dialog box when prompted for confirmation.

## How to increase EC2 instance volume's partition size?
1. Connect to your instance (via SSH, EC2 Instance Connect or AWS Session Manager)
2. Check the volume's partitions using the `lsblk` command.
Example:
```bash
[ec2-user ~]$ sudo lsblk
NAME		  MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme1n1       259:0    0  30G  0 disk /data
nvme0n1       259:1    0  16G  0 disk
└─nvme0n1p1   259:2    0   8G  0 part /
└─nvme0n1p128 259:3    0   1M  0 part
```
In the above example output, the root volume (`nvme0n1`) has two partitions (`nvme0n1p1` and `nvme0n1p128`), while the additional volume (`nvme1n1`) has no partitions.

3. Extend the partition. Use the **growpart** command and specify the partition to extend.
```bash
[ec2-user ~]$ sudo growpart /dev/nvme0n1 1
```
4. Verify that the partition has been extended. Use the `lsblk` command. The partition size should now be equal to the volume size.
``` bash
[ec2-user ~]$ sudo lsblk
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme1n1       259:0    0  30G  0 disk /data
nvme0n1       259:1    0  16G  0 disk
└─nvme0n1p1   259:2    0  16G  0 part /
└─nvme0n1p128 259:3    0   1M  0 part
```
The above example output shows that both the volume (nvme0n1) and the partition (nvme0n1p1) are the same size (16 GB).

5. Extend the file system: Get the name, size, type, and mount point for the file system that you need to extend. Use the **df -hT** command.
 ```  bash
[ec2-user ~]$ df -hT
Filesystem      Type  Size  Used Avail Use% Mounted on
/dev/nvme0n1p1  xfs   8.0G  1.6G  6.5G  20% /
/dev/nvme1n1    xfs   8.0G   33M  8.0G   1% /data
```
The following example output shows that the `/dev/nvme0n1p1` file system is 8 GB in size, its type is `xfs`, and its mount point is `/`.

6. The commands to extend the file system differ depending on the file system type.
**For file system type - XFS**
Use the **xfs_growfs** command and specify the mount point of the file system.
``` bash
[ec2-user ~]$ sudo xfs_growfs -d /
```
**For file system type - EXT4**
Use the **resize2fs** command and specify the name of the file system(/dev/nvme0n1p1)
``` bash
[ec2-user ~]$ sudo resize2fs /dev/nvme0n1p1
```
7. Verify that the file system has been extended. Use the **df -hT** command and confirm that the file system size is equal to the volume size.
