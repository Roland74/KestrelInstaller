#!/bin/bash
# Getting the outputdevice and check wether it is already mounted or not and try to umount it.
.  environment/outputdevice.sh
#echo "Our output device is $outputdevice. In case this device is mounted this script will unmount it !"

#echo 'mount | grep "$outputdevice" > /dev/null'
mount | grep "$outputdevice" > /dev/null
exitCode=$?
if [ $exitCode -ne 0 ]; then
#  echo "not mounted"
   echo
else 
###   echo "This output device is mounted so it has to be unmounted!"
###   echo "sudo umount `mount | grep $outputdevice | awk '{print $3}' | sed -z 's/\n/ /'`"
   sudo umount `mount | grep $outputdevice | awk '{print $3}' | sed -z 's/\n/ /'`
   exit
fi
