#!/bin/bash
#
# It returns the public domain name of the node which is accessible from outside of node network.

SCRIPT_DIR=$(dirname $(readlink -e $0))

unset publicDomain
dc=$($SCRIPT_DIR/getdc.sh)

# check datacenter and get public domain name
if [[ $dc =~ ^aws.*$ ]]; then
    echo $(wget -q -O - http://instance-data/latest/meta-data/public-hostname)
    exit
fi


