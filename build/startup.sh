#!/bin/bash

if [ "$SSHD_ENABLED" == "1" ];
then
  echo "starting sshd"
  /etc/init.d/ssh start
fi	

if [ "$RDPD_ENABLED" == "1" ];
then
  echo "starting rdp"
  /etc/init.d/xrdp start
fi	

#change password
if [  ${#ROOT_PASSWORD} -gt 1 ];
then 
  echo "password is rest to $ROOT_PASSWORD"
  echo "root:$ROOT_PASSWORD" | /usr/sbin/chpasswd
fi

/usr/sbin/cron -f
