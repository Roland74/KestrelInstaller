#!/bin/bash

# The wpa_supplicant.conf file is needed to use your wifi router to connect with the internet
### We will check whether the wpa_supplicant.conf  file exists. If not, we will create one.
# We will check if the wpa_supplicant.conf file exists. If not, we will create one.

TRANSFER_DIR=transfer
WPA_SUPPLICANT_CONF_FILE=wpa_supplicant.conf
WPA_SUPPLICANT_CONF_PATH=${TRANSFER_DIR}/${WPA_SUPPLICANT_CONF_FILE}
echo
echo

echo "This script will create your personal $WPA_SUPPLICANT_CONF_FILE file for using wifi in case no such file already exists in $TRANSFER_DIR."

if [ ! -f $WPA_SUPPLICANT_CONF_PATH ]; then
   echo
   read -p "Enter your SSID: " ssid
   read -p "Enter your wifi network key: " network_key
   echo
   echo 
   # create your wpa_supplicant.conf
   mkdir -p $TRANSFER_DIR
   echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > $WPA_SUPPLICANT_CONF_PATH
   echo "update_config=1" >> $WPA_SUPPLICANT_CONF_PATH
   echo >> $WPA_SUPPLICANT_CONF_PATH
   echo "network={" >> $WPA_SUPPLICANT_CONF_PATH
   echo "        ssid=\"${ssid}\"" >> $WPA_SUPPLICANT_CONF_PATH
   echo "        psk=\"${network_key}\"" >> $WPA_SUPPLICANT_CONF_PATH
   echo "}" >> $WPA_SUPPLICANT_CONF_PATH
   chmod 400 $WPA_SUPPLICANT_CONF_PATH
   echo "Your wifi configuration file has been created in $WPA_SUPPLICANT_CONF_PATH."
   echo
else
   echo "The file $WPA_SUPPLICANT_CONF_FILE already exists in the directory $TRANSFER_DIR, so we will go on."
   echo
fi 
