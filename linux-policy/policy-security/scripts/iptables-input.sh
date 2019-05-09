#!/bin/bash

[ -e ~/.secret/.env/env ] && . ~/.secret/.env/env
[ "${NTP}" != "" ] || exit 0
[ "${DNS1}" != "" ] || exit 0
[ "${DNS2}" != "" ] || exit 0

#
# INPUT policy
#

iptables -A INPUT -j LOG --log-prefix "[security-iptables-input] " -m comment --comment 'linux-policy'

iptables -D FORWARD -j LOG --log-prefix "[security-iptables-forward] " -m comment --comment 'linux-policy'
iptables -A FORWARD -j LOG --log-prefix "[security-iptables-forward] " -m comment --comment 'linux-policy'

iptables-save > /etc/iptables/rules.v4

#
# IPv6 drop
#

ip6tables -F INPUT
ip6tables -P INPUT DROP
ip6tables -F OUTPUT
ip6tables -P OUTPUT DROP
ip6tables -F FORWARD
ip6tables -P FORWARD DROP

ip6tables-save > /etc/iptables/rules.v6
