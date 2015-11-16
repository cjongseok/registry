#!/bin/bash
#
# It assumes Consul is running on Docker host and its port is 8500.
# DOCKER_HOST_IP and DOCKER_HOST_NAME are required!
#
# Author: Jongseok Choi

SCRIPT_DIR=$(dirname $(readlink -e $0))
DOCKER_HOST_IP=172.31.17.125
DOCKER_HOST_NAME=ip-172-31-17-125

#SERVICE_JSON=service.json
CONSUL_HOST=$DOCKER_HOST_IP:8500
CONSUL_REGISTRATION_URL=http://$CONSUL_HOST/v1/catalog/register
#CONSUL_REGISTRATION_URL=http://$CONSUL_HOST/v1/agent/service/register


# get node info 

# generate full service description including node info
jsonStr=$(jq '. + { "Datacenter": "'$DOCKER_HOST_DC'", "Node": "'$DOCKER_HOST_NAME'", "Address":"'$DOCKER_HOST_FQDN'"}' $SERVICE_JSON)
#jsonStr=$(jq '. + { "Node": "'$DOCKER_HOST_NAME'", "Address":"'$DOCKER_HOST_FQDN'"}' $SERVICE_JSON)

# register service
echo "curl -X PUT -d ''"$jsonStr"'' $CONSUL_REGISTRATION_URL"
curl -X PUT -d ''"$jsonStr"'' $CONSUL_REGISTRATION_URL
