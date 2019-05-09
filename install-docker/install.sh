#!/bin/bash

sudo apt install docker.io -y
sudo systemctl enable docker

# https://serverfault.com/questions/642981/docker-containers-cant-resolve-dns-on-ubuntu-14-04-desktop-host
# fix docker container domain name resovling issue
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

sudo usermod -a -G docker `whoami`

