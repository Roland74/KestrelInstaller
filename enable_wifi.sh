#!/bin/sh
TRANSFER_DIR=transfer
# get the environment variable for the outputdevice
. environment/environment.sh
./wpa_supplicant.sh
mount | grep "$mnt_rootfs" 
exitCode=$?
if [ $exitCode -ne 0 ]; then
   echo "$mnt_rootfs is not mounted."
   exit 1
else
   echo "copying wifi related files"
   cp -aRv ${TRANSFER_DIR}/wpa_supplicant.conf ${mnt_rootfs}/etc/wpa_supplicant/
   cp -aRv ${TRANSFER_DIR}/interfaces ${mnt_rootfs}/etc/network/
   cp -aRv ${TRANSFER_DIR}/80-wifi.conf ${mnt_rootfs}/etc/NetworkManager/conf.d
fi
