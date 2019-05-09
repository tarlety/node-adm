#!/bin/bash

VERSION="linux-policy-security v1"

[ -e ~/.secret/.env/env ] && . ~/.secret/.env/env
[ "${SSHPORT}" != "" ] || exit 0
[ "${NTP}" != "" ] || exit 0
[ "${SMTP}" != "" ] || exit 0
[ "${MAILTO}" != "" ] || exit 0
[ "${GRUBUSER}" != "" ] || exit 0
[ "${GRUBPASSWORD}" != "" ] || exit 0

echo Security Policy Apply
echo ===

echo
echo \#\# Report Info
echo

echo "Hostname: `hostname`"
echo "Date: `date`"

echo
echo \#\# Set timezone from default UTC to Asia/Tapei
echo

sudo timedatectl set-timezone Asia/Taipei
sudo systemctl status systemd-timesyncd

