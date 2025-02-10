#!/bin/bash
# Create the ipset list
ipset -N russia hash:net

# Remove if existing zone downloaded
rm -f ru-aggregated.zone

# Pull the latest IP set for Russia
wget -P . http://www.ipdeny.com/ipblocks/data/aggregated/ru-aggregated.zone

# Add each IP address from the downloaded list into the ipset 'russia'
for i in $(cat ./ru-aggregated.zone ); do ipset -A russia $i; done

COMMAND="netfilter-persistent"

if which "$COMMAND" > /dev/null 2>&1; then
    sudo netfilter-persistent save
else
    echo "iptables-persistent needs to be installed available."
fi
