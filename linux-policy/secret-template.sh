#!/bin/bash

echo "WARNING!! continue to ERASE all your existing secrets!!!"
read -p "Enter Y to continue:" Y
[ "$Y" == "Y" ] || exit 0

#
# .env/env
#

[[ "${SECRET}" == "" ]] && SECRET=~/.secret
ENV=${SECRET}/.env
mkdir -p ${ENV}

SECRET_SSHPORT=`cat /etc/ssh/sshd_config | grep '^Port' | cut -d ' ' -f 2`
[[ "$SECRET_SSHPORT" == "" ]] && SECRET_SSHPORT=22
echo SSHPORT=$SECRET_SSHPORT > ${ENV}/env
echo "[env] SSHPORT=$SECRET_SSHPORT"

read -p "[env] NTP:" NTP
echo "NTP=$NTP" >> ${ENV}/env

read -p "[env] DNS1:" DNS1
echo "DNS1=$DNS1" >> ${ENV}/env

read -p "[env] DNS2:" DNS2
echo "DNS2=$DNS2" >> ${ENV}/env

read -p "[env] SMTP:" SMTP
echo "SMTP=$SMTP" >> ${ENV}/env

read -p "[env] MAILTO:" MAILTO
echo "MAILTO=$MAILTO" >> ${ENV}/env

read -p "[env] OPERATOR:" OPERATOR
echo "OPERATOR=$OPERATOR" >> ${ENV}/env

read -p "[env] GRUBUSER:" GRUBUSER
echo "GRUBUSER=$GRUBUSER" >> ${ENV}/env

grub-mkpasswd-pbkdf2
read -p "[env] GRUBPASSWORD:" GRUBPASSWORD
echo "GRUBPASSWORD=$GRUBPASSWORD" >> ${ENV}/env

read -p "[env] DOMAIN for certs (ex: site.domain):" SUBJECT
echo "SUBJECT=$SUBJECT" >> ${ENV}/env

read -p "[env] SUBJECT for certs (ex: /C=TW/ST=state/L=city/O=org/OU=depart/CN=dn):" SUBJECT
echo "SUBJECT=$SUBJECT" >> ${ENV}/env

#
# .env/hosts
#

cp /etc/hosts ${ENV}/hosts

