#!/bin/bash

echo Security Check Report
echo ===

echo
echo \#\# Report Info
echo

echo "Hostname: `hostname`"
echo "Date: `date`"

echo
echo \#\# Check Listening Network Ports
echo

echo $ sudo netstat -tulpn
sudo netstat -tulpn

echo
echo \#\# Accounts with valid shell
echo

echo checking /etc/passwd...
ACCOUNTS=`cat /etc/passwd | grep -v /usr/sbin/nologin | grep -v /bin/false | grep -v /bin/sync | cut -d ':' -f 1`
for user in $ACCOUNTS
do
	echo "Account: $user"
	sudo chage -l $user
done

echo
echo \#\# iptables status
echo

echo $ sudo iptables -L -v
sudo iptables -L -v

echo
echo \#\# empty password check
echo

echo checking /etc/shadow...
EMPTYPASSWORDS=`sudo cat /etc/shadow | awk -F: '($2==""){print $1}'`
if [ "${EMPTYPASSWORDS}" != "" ]
then
	echo "result: FAIL"
	echo "accounts with empty password:"
	echo ${EMPTYPASSWORDS}
fi

echo
echo \#\# do not use sudoers.d
echo

ls /etc/sudoers.d/
[ "`ls /etc/sudoers.d`" == "README" ] && echo "result: passed" || echo "result: FAIL"

echo
echo \#\# log check
echo

ls -al /var/log/kern.log
ls -al /var/log/auth.log
ls -al /var/log/wtmp

echo
echo \#\# Disk controller vendor
echo

echo $ lsscsi
lsscsi

