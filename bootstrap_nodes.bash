#!/bin/bash

function getip() { (traceroute $1 2>&1 | head -n 1 | cut -d\( -f 2 | cut -d\) -f 1) }

export MASTER=$(getip swarm-master.local)
TOKEN="SWMTKN-1-1ns07zggonmb559sr8fpdu80lslbgg3rungahxi9bkiu1qlzi4-blln73r6hi3myik1o4362nvq5"

# Reset.
ssh -i id_rsa pirate@swarm-pi-1.local docker swarm leave
ssh -i id_rsa pirate@swarm-pi-2.local docker swarm leave
ssh -i id_rsa pirate@swarm-pi-3.local docker swarm leave

# Join.
ssh -i id_rsa pirate@swarm-pi-1.local docker swarm join --token $TOKEN $MASTER:2377
ssh -i id_rsa pirate@swarm-pi-2.local docker swarm join --token $TOKEN $MASTER:2377
ssh -i id_rsa pirate@swarm-pi-3.local docker swarm join --token $TOKEN $MASTER:2377
