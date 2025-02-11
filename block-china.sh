#!/bin/bash

# Check if the script is running with sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root or with sudo."
    exit 1
fi

# Cleanup
removedldfile() {
    # Remove if file exist
    rm -f ./cn-aggregated.zone
}

removedldfile

# Create the ipset list
ipset -N china hash:net



# Pull the latest IP set for China
wget -P . https://www.ipdeny.com/ipblocks/data/aggregated/cn-aggregated.zone

# Add each IP address from the downloaded list into the ipset 'china'
for i in $(cat ./cn-aggregated.zone ); do ipset -A china $i; done

removedldfile

COMMAND="netfilter-persistent"

if which "$COMMAND" > /dev/null 2>&1; then
    sudo netfilter-persistent save
else
    echo "iptables-persistent needs to be installed available."
fi
