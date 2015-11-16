#!/bin/bash
#
# It assumes Consul is running on Docker host and its port is 8500.
# DOCKER_HOST_IP and DOCKER_HOST_NAME are required!
#
# Author: Jongseok Choi

SCRIPT_DIR=$(dirname $(readlink -e $0))
#DOCKER_HOST_IP=172.31.17.125
#DOCKER_HOST_NAME=ip-172-31-17-125

SERVICE_JSON=service.json
CONSUL_HOST=$DOCKER_HOST_IP:8500
CONSUL_REGISTRATION_URL=http://$CONSUL_HOST/v1/catalog/register


# get node info 
DATACENTER=$($SCRIPT_DIR/getdc.sh)
PUBLIC_DOMAIN=$($SCRIPT_DIR/getdomain.sh)

# generate full service description including node info
jsonStr=$(jq '. + { "Node": "'$DOCKER_HOST_NAME'", "Address":"'$DOCKER_HOST_IP'"}' $SERVICE_JSON)

# register service
curl -X PUT -d ''"$jsonStr"'' $CONSUL_REGISTRATION_URL
