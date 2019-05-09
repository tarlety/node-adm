#!/bin/bash

echo
echo \#\# Set timezone from default UTC to Asia/Tapei
echo

sudo timedatectl set-timezone Asia/Taipei
sudo systemctl status systemd-timesyncd

