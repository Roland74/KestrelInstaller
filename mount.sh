#!/bin/sh
. environment/environment.sh
. environment/outputdevice.sh
mkdir -p $mnt_rootfs
mkdir -p $mnt_bootfs
mount ${outputdevice}2 $mnt_rootfs
exitCode=$?
if [ $exitCode -ne 0 ]; then
   rmdir $mnt_rootfs
else
   echo "mounted $mnt_rootfs"
fi

mount ${outputdevice}1 $mnt_bootfs
exitCode=$?
if [ $exitCode -ne 0 ]; then
   rmdir $mnt_bootfs
else
   echo "mounted $mnt_bootfs"
fi
