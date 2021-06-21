#!/bin/bash
wget -O '/var/tmp/default.txt' https://cdn.jsdelivr.net/gh/fernvenue/adguard-home-upstream/v4.conf
wget -O '/var/tmp/chinalist.txt' https://cdn.jsdelivr.net/gh/felixonmars/dnsmasq-china-list/accelerated-domains.china.conf
wget -O '/var/tmp/applechina.txt' https://cdn.jsdelivr.net/gh/felixonmars/dnsmasq-china-list/apple.china.conf
sed -i 's|server=|[|g' '/var/tmp/chinalist.txt'
sed -i 's|114.114.114.114|]tls://223.5.5.5|g' '/var/tmp/chinalist.txt'
sed -i 's|server=|[|g' '/var/tmp/applechina.txt'
sed -i 's|114.114.114.114|]tls://223.5.5.5|g' '/var/tmp/applechina.txt'
cat '/var/tmp/default.txt' '/var/tmp/applechina.txt' '/var/tmp/chinalist.txt' > /usr/local/AdGuardHome/upstream.txt
rm -rf '/var/tmp/default.txt' '/var/tmp/applechina.txt' '/var/tmp/chinalist.txt'
systemctl restart AdGuardHome
