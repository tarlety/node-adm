#!/bin/bash

# https://medium.com/@CameronSparr/increase-os-udp-buffers-to-improve-performance-51d167bb1360
# incrase UDP buffer to improve performance
grep -F "linux-policy 1: increase UDP buffer" /etc/sysctl.conf || {
	echo "# linux-policy 1: increase UDP buffer" | sudo tee -a /etc/sysctl.conf
	echo "net.core.rmem_max=26214400" | sudo tee -a /etc/sysctl.conf
	echo "net.core.rmem_default=26214400" | sudo tee -a /etc/sysctl.conf
	sudo sysctl -p
}
