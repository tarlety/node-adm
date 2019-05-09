#!/bin/bash

echo
echo \# policy-seuciry-hosts
echo

cd policy-security; ./policy-security-hosts.sh; cd ..

echo
echo \# policy-packages/update
echo

cd policy-packages; ./update.sh; cd ..

echo
echo \# policy-packages/install
echo

cd policy-packages; ./install.sh; cd ..

echo
echo \# policy-seuciry-apply
echo

cd policy-security; ./policy-security-apply.sh; cd ..
