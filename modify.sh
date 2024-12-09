#!/bin/bash
echo
echo "         *** Stage 3 of 3 ***     "
echo
# sourcing the environment script
. environment/environment.sh
./mount.sh
if [ -d $mnt_bootfs ]; then
   touch $mnt_bootfs/ssh
   echo "created empty file 'ssh' in $mnt_bootfs/ssh"
   ./userconf.sh
   cp -aRv transfer/userconf $mnt_bootfs/
fi
chown root:root transfer/*
echo
if [ -d $mnt_rootfs ]; then
   ./enable_wifi.sh
   cp transfer/hostname ${mnt_rootfs}/etc
   echo " enabling ssh permanently"
   cp -aRv transfer/ssh* $mnt_rootfs/lib/systemd/system
   touch $mnt_rootfs/lib/systemd/system/ssh*
   echo 
   echo "user configuration and ssh access finished"
fi
echo
echo
./umount.sh
echo "All done, have fun !"
sync 
echo
echo
