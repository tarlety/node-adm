#!/bin/bash

# https://serverfault.com/questions/143968/automate-the-installation-of-postfix-on-ubuntu
# set logwatch/postfix to use smtp
sudo debconf-set-selections <<< "postfix postfix/relayhost string ${SMTP}"
sudo debconf-set-selections <<< "postfix postfix/mailname string `hostname`"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Satellite system'"
sudo apt install logwatch -y
sudo cp files/logwatch.conf /etc/logwatch/conf
sudo cp files/kernel.conf /etc/logwatch/conf/services

