#!/bin/bash

# Create the ipset list
ipset -N china hash:net

# Remove any old list that might exist from previous runs of this script
rm -f cn-aggregated.zone

# Pull the latest IP set for China
wget -P . https://www.ipdeny.com/ipblocks/data/aggregated/cn-aggregated.zone

# Add each IP address from the downloaded list into the ipset 'china'
for i in $(cat ./cn-aggregated.zone ); do ipset -A china $i; done

COMMAND="netfilter-persistent"

if which "$COMMAND" > /dev/null 2>&1; then
    sudo netfilter-persistent save
else
    echo "iptables-persistent needs to be installed available."
fi
