#!/bin/bash

# The userconf file is needed to create a valid user for the raspberry Pi.
# We will check whether the userconf file exists. If not, we will create one.

TRANSFER_DIR=transfer
USERCONF_FILE=userconf
USERCONF_PATH=${TRANSFER_DIR}/${USERCONF_FILE}
echo
echo

echo "This script will create your personal ${USERCONF_FILE} file in case no such file already exists in the directory $TRANSFER_DIR."
echo
if [ ! -f $USERCONF_PATH ]; then
#  echo "The file ${USERCONF_FILE} does not exist so we will create it now:"
   echo "For the username only lowercase letters are allowed."
   echo
   read -p "Enter your username: " username
   # check that this username is at least one and a maximum of 31 letters long
   while [ ${#username} -lt 2 ] || [ ${#username} -gt 32 ] || [[ ${username}  =~ [A-Z] ]]; do
      echo "Enter a username with lowercase letters only, a minimum length of 2 and a maximum length of 32 letters."
      read -p "username: " username
   done 
   echo
   read -sp "Enter your password: " passwd1
   echo
   read -sp "Re-enter this password: " passwd2
   while [ $passwd1 != $passwd2 ]; do
       echo
       echo "They don't match, try again."
       read -sp "Enter your password: " passwd1
       echo
       read -sp "Re-enter this password: " passwd2
   done
   echo 
   echo 
   # create an openssl encrypted passwd
   mkdir -p $TRANSFER_DIR
   encrypted_passwd=`echo ${passwd2} | openssl passwd -6 -stdin`
   echo ${username}:${encrypted_passwd} > ${USERCONF_PATH}
   echo "Your username and password have been encrypted and transferred to file '${USERCONF_PATH}' which is now ready for use."
   echo
   echo "Have fun! "
   echo
else
   echo "A file called $USERCONF_FILE already exists in the directory $TRANSFER_DIR, so we will go on."
fi 
