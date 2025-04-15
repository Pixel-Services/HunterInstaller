#!/bin/bash

if [[ $(/usr/sbin/ipset list | grep "blacklist") == "" ]]; then
    /usr/sbin/ipset create blacklist hash:ip
fi
if [[ $(/usr/sbin/iptables -w 2 -n -L DOCKER-USER | grep "blacklist") == "" ]]; then
    /usr/sbin/iptables -I DOCKER-USER -m set --match-set blacklist src -j DROP
fi

blocked_ips=$(curl -s "https://raw.githubusercontent.com/pebblehost/hunter/master/ips.txt")
# Adjust the ipset with the IPs
ipsetrules=$(/usr/sbin/ipset list blacklist | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
for ip in $blocked_ips; do
    if [[ $(echo "$ipsetrules" | grep "$ip") == "" ]]; then
        echo "Applying block to $ip"
        /usr/sbin/ipset add blacklist "$ip"/32
    fi
done

for ip in $ipsetrules; do
    if [[ $(echo "$blocked_ips" | grep "$ip") == "" ]]; then
        echo "Removing block from $ip"
        /usr/sbin/ipset del blacklist "$ip"
    fi
done
unset IFS
