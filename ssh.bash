#!/bin/bash

echo
echo NOTE: Default password for the “pirate” user is “hypriot”
echo Copying local ssh_keys.pub to hosts
echo

function getip() { (traceroute $1 2>&1 | head -n 1 | cut -d\( -f 2 | cut -d\) -f 1) }

export MASTER=$(getip swarm-master.local)
echo $MASTER

export SLAVE_1=$(getip swarm-pi-1.local)
echo $SLAVE_1

export SLAVE_2=$(getip swarm-pi-2.local)
echo $SLAVE_2

export SLAVE_3=$(getip swarm-pi-3.local)
echo $SLAVE_3

ssh-copy-id -i id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no pirate@$MASTER
ssh-copy-id -i id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no pirate@$SLAVE_1
ssh-copy-id -i id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no pirate@$SLAVE_2
ssh-copy-id -i id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no pirate@$SLAVE_3
