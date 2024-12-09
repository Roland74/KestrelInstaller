#!/bin/sh
# Try to unmount if bootfs and rootfs are mounted to /media/$USER
# Dump the image to the output device e.g. SD card 
./create.sh
exitCode=$?
if [ $exitCode -ne 0 ]; then
   exit 1
fi
# mount the output device and do some small modifications and later unmount it.
./modify.sh
