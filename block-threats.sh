#!/bin/bash

# Create the ipset list
ipset -N emergetreats hash:net

# Remove if existing zone downloaded
rm -f ./emerging-Block-IPs.txt

# Pull the latest IP set for Emerging Threats Spamhaus DROP List rules.
wget -P . https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt

# Define the file to read
input_file="emerging-Block-IPs.txt"

# Read each line and add the IP address from the downloaded list into the ipset 'emergetreats'
while IFS= read -r line; do
    # Ignore commented lines and blank lines
    if [[ ! $line =~ ^# ]] && [[ -n $line ]]; then
        # Execute the action with the line
        ipset -A emergetreats $i "$line"
    fi
done < "$input_file"

#Check if persistent IPTBALES is installed
COMMAND="netfilter-persistent"

if which "$COMMAND" > /dev/null 2>&1; then
    sudo netfilter-persistent save
else
    echo "iptables-persistent needs to be installed available."
fi
