#!/bin/bash

# Enable DNS for docker containers
echo "Adding DNS to docker config"
DAEMON_CONFIG_FILE='/etc/docker/daemon.json'
DNS=$(/usr/bin/nmcli dev show | grep 'IP4.DNS' | /usr/bin/awk '{print $2}')
DNS="{
    \"dns\": [\"$DNS\"]
}
"
echo "$DNS" | sudo tee -a $DAEMON_CONFIG_FILE > /dev/null
