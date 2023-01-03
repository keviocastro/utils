#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "You need to run this script with root!"
   exit 1
fi

function help(){
    echo "route-all-traefik.sh -g <vpn gateway ip> -i <vpn interface>"
}

while getops g:i:? option; do
    case "$option" in
    g)
        GATEWAY_IP="${OPTARG}"
        ;;
    a)
        NETWORK_INTERFACE=${OPTARG}
        ;;
    * | ?)
        help
        exit 1;
        ;;
    esac
done

if [ -z "$GATEWAY_IP" ]; then
    echo "-g param (GATEWAY_IP) is required."
fi

if [ -z "$NETWORK_INTERFACE" ]; then
    echo "-g param (NETWORK_INTERFACE) is required."
fi

route -nv add -net 10 -interface $NETWORK_INTERFACE
route change default $GATEWAY_IP
