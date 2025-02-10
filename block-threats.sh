#!/bin/bash
# Create the ipset list
ipset -N emergetreats hash:net

# Remove if existing zone downloaded
rm -f ./emerging-Block-IPs.txt

# Pull the latest IP set for Emerging Threats Spamhaus DROP List rules.
wget -P . https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt

# Add each IP address from the downloaded list into the ipset 'emergetreats'
for i in $(cat ./emerging-Block-IPs.txt ); do ipset -A emergetreats $i; done

COMMAND="netfilter-persistent"

if which "$COMMAND" > /dev/null 2>&1; then
    sudo netfilter-persistent save
else
    echo "iptables-persistent needs to be installed available."
fi
