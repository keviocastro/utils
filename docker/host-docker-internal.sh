#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "You need to run this script with root!"
   exit 1
fi

if [ "$(uname)" == "Darwin" ]; then
   ip=$(ipconfig getifaddr en0)
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    ip=$(hostname -I)
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "This script is not supported for windows"
    exit 1
fi

if cat /etc/hosts | grep host.docker.internal; then
   sed -iE "s/.*host\.docker\.internal/$ip host\.docker\.internal/g" /etc/hosts
else 
    echo -en "\n$ip host.docker.internal" >> /etc/hosts
fi

