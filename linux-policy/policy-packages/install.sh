#!/bin/bash

[ -e ~/.secret/.env/env ] && . ~/.secret/.env/env
[ "${SMTP}" != "" ] || exit 0

sudo apt install docker.io -y
sudo systemctl enable docker

# https://serverfault.com/questions/642981/docker-containers-cant-resolve-dns-on-ubuntu-14-04-desktop-host
# fix docker container domain name resovling issue
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

# https://serverfault.com/questions/143968/automate-the-installation-of-postfix-on-ubuntu
# set logwatch/postfix to use smtp
sudo debconf-set-selections <<< "postfix postfix/relayhost string ${SMTP}"
sudo debconf-set-selections <<< "postfix postfix/mailname string `hostname`"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Satellite system'"
sudo apt install logwatch -y
sudo cp files/logwatch.conf /etc/logwatch/conf
sudo cp files/kernel.conf /etc/logwatch/conf/services

# https://gist.github.com/alonisser/a2c19f5362c2091ac1e7
# install iptables-persistent without manual input
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo apt install iptables-persistent -y

sudo apt install lsscsi -y
sudo apt install gnupg2 -y

sudo usermod -a -G docker `whoami`

# https://medium.com/@CameronSparr/increase-os-udp-buffers-to-improve-performance-51d167bb1360
# incrase UDP buffer to improve performance
grep -F "linux-policy 1: increase UDP buffer" /etc/sysctl.conf || {
	echo "# linux-policy 1: increase UDP buffer" | sudo tee -a /etc/sysctl.conf
	echo "net.core.rmem_max=26214400" | sudo tee -a /etc/sysctl.conf
	echo "net.core.rmem_default=26214400" | sudo tee -a /etc/sysctl.conf
	sudo sysctl -p
}
