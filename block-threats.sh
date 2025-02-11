#!/bin/bash

# Check if the script is running with sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root or with sudo."
    exit 1
fi

# Remove the temporary file if it exists
removetmpfile() {
    rm -f ./data.tmp
}

blockgroupname="emergetreats"
file_url="https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt"

# Cleanup
removetmpfile

# Create the ipset list
ipset -N $blockgroupname hash:net

# Download the IPs list and store as data.tmp
wget -O data.tmp "$file_url"

# Read each line and add the IP address from the downloaded list into the ipset '$blockgroupname'
while IFS= read -r line; do
    # Ignore commented lines and blank lines
    if [[ ! $line =~ ^# ]] && [[ -n $line ]]; then
        # Execute the action with the line
        ipset -A $blockgroupname "$line"
    fi
done < "data.tmp"

# Cleanup
removetmpfile

# Check if persistent IPTABLES is installed
COMMAND="netfilter-persistent"

if which "$COMMAND" > /dev/null 2>&1; then
    sudo netfilter-persistent save
else
    echo "iptables-persistent needs to be installed."
    echo "sudo apt install iptables-persistent"
fi
