# Create the ipset list
ipset -N china hash:net

# remove any old list that might exist from previous runs of this script
rm cn-aggregated.zone

# Pull the latest IP set for China
wget -P . https://www.ipdeny.com/ipblocks/data/aggregated/cn-aggregated.zone

# Add each IP address from the downloaded list into the ipset 'china'
for i in $(cat /etc/cn-aggregated.zone ); do ipset -A china $i; done

# Restore iptables
/sbin/iptables-restore < /etc/iptables.firewall.rules
