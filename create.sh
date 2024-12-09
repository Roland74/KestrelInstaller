#!/bin/bash
outputdevice=/dev/sda
image=iso/2024-11-19-raspios-bookworm-arm64-lite.img
scriptpath=$0
clear
echo
echo "This script will write a bootable raspberry pi iso image to $outputdevice."
# Please check to which output device you want to dump the image to and enter the correct value for
# the script variable outputdevice in line 2. Please be careful and check with e.g. lsblk, dmesg
# This scripts write the outputdevice variable into a source script environment/outputdevice.sh that will be sourced in later 
# scripts to use this output device for mounting.
# Comment in the line for dd and parted if everything is correct
echo "# The outputdevice variable from this source script is used for mounting and unmounting" > environment/outputdevice.sh
echo "export outputdevice=${outputdevice}" >> environment/outputdevice.sh 
./raspberry_umount.sh
# Check if the specified iso image is readable on the filesystem and exits if the image file is not found
if [ ! -f $image ]; then
   echo "The iso image $image does not exist."
   echo "Please make an iso image available and put the correct name in the image varaible of this script."
   exit 1
fi
# Check if the dd comment line is already already active
hashchar="#"
cat $scriptpath | fgrep "${hashchar}dd" > /dev/null
exitCode=$?
if [ $exitCode -eq 0 ]; then
   echo "Please check the outputdevice variable if $outputdevice points to the correct output device."
   echo "Be careful and check for the correct output device with e.g. lsblk."
   echo "The dd command can corrupt your data on the output device!"
   echo "If the the output device is correct please activate the dd command line."
   exit 1
fi
echo
echo
echo "          *** Stage 1 of 3 ***         "
echo
echo "creating new arm64 image on ${outputdevice}, this may take a while ..."
echo
echo dd status=progress if=${image} of=${outputdevice}
#dd status=progress if=${image} of=${outputdevice}
sleep 2
echo
echo "          *** Stage 2 of 3 ***         "
echo 
echo "resizing ${outputdevice}2 to full size"
echo
echo "parted ${outputdevice} resizepart 2 100% && sync && e2fsck -f -y ${outputdevice}2 && sync && resize2fs ${outputdevice}2 && sync"
parted ${outputdevice} resizepart 2 100% && sync && e2fsck -f -y ${outputdevice}2 && sync && resize2fs ${outputdevice}2 && sync
echo
###echo " restart device and run './modify.sh' afterwards"
echo " Mounting ${outputdevice}2 and running './modify.sh' now"
echo
echo
sleep 2
