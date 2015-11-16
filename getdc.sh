#!/bin/bash
#
# It figures out that the datacenter of the local machine

# AWS
dc=$(wget -q -O - http://instance-data/latest/meta-data/placement/availability-zone)

if [ -n $dc ]; then
    echo "aws-${dc}"
    exit
fi

# Baremetal
