#!/bin/bash
DATE=`date --rfc-3339 sec`
echo "$DATE: IPv4 connection testing..."
if ping -c 3 "101.6.6.6" > /dev/null 2>&1; then
	IPv4="true"
fi
echo "$DATE: IPv6 connection testing..."
if ping -c 3 "2001:da8::666" > /dev/null 2>&1; then
	IPv6="true"
fi
if [[ $IPv4 == "true" ]]; then
	if [[ $IPv6 == "true" ]]; then
		echo "$DATE: IPv4 and IPv6 connections both available."
		curl -o "/var/tmp/default.upstream" https://gitlab.com/fernvenue/adguardhome-upstream/-/raw/master/v6.conf > /dev/null 2>&1
	else
		echo "$DATE: IPv4 connection available."
		curl -o "/var/tmp/default.upstream" https://gitlab.com/fernvenue/adguardhome-upstream/-/raw/master/v4.conf > /dev/null 2>&1
	fi
else
	if [[ $IPv6 == "true" ]]; then
		echo "$DATE: IPv6 connection available."
		curl -o "/var/tmp/default.upstream" https://gitlab.com/fernvenue/adguardhome-upstream/-/raw/master/v6only.conf > /dev/null 2>&1
	else
		echo "ERROR: No available network connection was detected, please try again."
	fi
fi
echo "$DATE: Getting data updates..."
curl -o "/var/tmp/chn.aapl.upstream" https://gitlab.com/fernvenue/chn-domains-list/-/raw/master/CHN.AAPL.txt > /dev/null 2>&1
curl -o "/var/tmp/chn.goog.upstream" https://gitlab.com/fernvenue/chn-domains-list/-/raw/master/CHN.GOOG.txt > /dev/null 2>&1
curl -o "/var/tmp/chn.upstream" https://gitlab.com/fernvenue/chn-domains-list/-/raw/master/CHN.txt > /dev/null 2>&1
echo "$DATE: Processing data format..."
sed -i "s|^|[/|g" /var/tmp/chn*upstream
sed -i "s|$|/]tls://223.5.5.5|g" /var/tmp/chn*upstream
cat "/var/tmp/chn.aapl.upstream" "/var/tmp/chn.goog.upstream" "/var/tmp/chn.upstream" | perl -CIOED -p -e "s/^.*\p{Script_Extensions=Han}.*$//g" > /var/tmp/adguardhome.upstream
sed -i "/^$/d" /var/tmp/adguardhome.upstream
cat "/var/tmp/default.upstream" "/var/tmp/adguardhome.upstream" > /usr/share/adguardhome.upstream
rm -rf /var/tmp/*.upstream
echo "$DATE: Clearing..."
systemctl restart AdGuardHome
echo "$DATE: All finished!"
