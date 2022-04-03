#!/bin/bash
clear
#JOEL SALVADOR MARCOS
if [ "$(id -u)" != "0" ]; then
	echo "Ejecuta este script como root (o usando sudo)."
	exit 1
fi

filename=$(echo "dhcpd.conf.$(date +"%y%m%d%H%M")")


echo -n "Domain name: "
read domain_name

echo -n "IP DNS primary "
read ip_dns_primary

echo -n "IP Gateway "
read ip_gateway

echo -n "Leasing default value: "
read leasing_default

echo -n "Leasing MAX value: "
read leasing_max

echo -n "Subnet IP address: "
read ip_address

echo -n "Subnet MASK address: "
read mask_address
echo""
echo -n "Initial DHCP IP range: "
read ini_dhcp_ip_range
echo""
echo -n "Final DHCP IP range: "
read fin_dhcp_ip_range
echo""
echo "COPYING dhcp.conf TO $filename"
cp /etc/dhcp/dhcpd.conf /etc/dhcp/$filename
echo""
echo "DELETING dhcpd.conf"
rm /etc/dhcp/dhcpd.conf
echo""
echo "CREATING NEW dhcpd.conf"
touch /etc/dhcp/dhcpd.conf
echo""
echo "ADDING CONFIGURATION TO dhcpd.conf"

echo "authoritative;" >> /etc/dhcp/dhcpd.conf
echo "ddns-update-style none;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name \"$domain_name\";" >> /etc/dhcp/dhcpd.conf
echo "option domain-name-servers $ip_dns_primary;" >> /etc/dhcp/dhcpd.conf
echo "option routers $ip_gateway;" >> /etc/dhcp/dhcpd.conf
echo "default-lease-time $leasing_default;" >> /etc/dhcp/dhcpd.conf
echo "max-lease-time $leasing_max;" >> /etc/dhcp/dhcpd.conf
echo "subnet $ip_address netmask $mask_address {" >> /etc/dhcp/dhcpd.conf
echo "range $ini_dhcp_ip_range $fin_dhcp_ip_range;" >> /etc/dhcp/dhcpd.conf
echo "}" >> /etc/dhcp/dhcpd.conf
echo""


echo "**DHCPD.CONF CONFIGURATION**"
cat /etc/dhcp/dhcpd.conf
echo""


systemctl restart isc-dhcp-server 2> /dev/null

exit 0
