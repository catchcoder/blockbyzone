# Create the ipset list
ipset -N russia hash:net

# remove any old list that might exist from previous runs of this script
rm ru-aggregated.zone

# Pull the latest IP set for Russia
wget -P . http://www.ipdeny.com/ipblocks/data/aggregated/ru-aggregated.zone

# Add each IP address from the downloaded list into the ipset 'russia'
for i in $(cat /etc/ru-aggregated.zone ); do ipset -A russia $i; done

# Restore iptables
/sbin/iptables-restore < /etc/iptables.firewall.rules
