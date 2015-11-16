#!/bin/bash

readonly CONSUL_CHECK_URL=http://$DOCKER_HOST_IP:8500/v1/agent/checks

echo "DOCKER_HOST_IP=$DOCKER_HOST_IP"
echo "DOCKER_HOST_NAME=$DOCKER_HOST_NAME"

# wait for consul
waiting_count=1
while true; do
    echo "waiting for Consul... ($waiting_count)"

    check_result="$(wget -q -O - $CONSUL_CHECK_URL)"
    if [ -n "$check_result" ]; then
        break;
    fi

    sleep 1
    ((waiting_count++))
done

# register registry to Consul
./register-service.sh

# run registry
/bin/registry /etc/docker/registry/config.yml
