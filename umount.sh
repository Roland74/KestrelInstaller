#!/bin/sh
. environment/environment.sh
###echo "umount $mnt_rootfs"
umount $mnt_rootfs
rmdir $mnt_rootfs

###echo "umount $mnt_bootfs"
umount $mnt_bootfs
rmdir $mnt_bootfs
