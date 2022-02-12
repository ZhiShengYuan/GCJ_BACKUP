#!/bin/bash
wget -O '/var/tmp/default.txt' https://cdn.jsdelivr.net/gh/fernvenue/adguard-home-upstream/v4.conf
wget -O '/var/tmp/chinalist.txt' https://cdn.jsdelivr.net/gh/felixonmars/dnsmasq-china-list/accelerated-domains.china.conf
wget -O '/var/tmp/applechina.txt' https://cdn.jsdelivr.net/gh/felixonmars/dnsmasq-china-list/apple.china.conf
sed -i 's|server=|[|g' '/var/tmp/chinalist.txt'
sed -i 's|114.114.114.114|]tls://223.5.5.5|g' '/var/tmp/chinalist.txt'
sed -i 's|server=|[|g' '/var/tmp/applechina.txt'
sed -i 's|114.114.114.114|]tls://223.5.5.5|g' '/var/tmp/applechina.txt'
# The following line is used to temporarily solve the issue that `upstream_dns_file` does not support Chinese domains.
# More about this issue: https://github.com/AdguardTeam/AdGuardHome/issues/2915
cat '/var/tmp/applechina.txt' '/var/tmp/chinalist.txt' | perl -CIOED -p -e 's/^.*\p{Script_Extensions=Han}.*$//g' > /var/tmp/upstream.txt
sed -i '/^$/d' /var/tmp/upstream.txt
# When the upstream solves this problem in the future, changes need to be made here.
cat '/var/tmp/default.txt' '/var/tmp/upstream.txt' > /usr/share/upstream.txt
rm -rf '/var/tmp/default.txt' '/var/tmp/applechina.txt' '/var/tmp/chinalist.txt' '/var/tmp/upstream.txt'
systemctl restart AdGuardHome
