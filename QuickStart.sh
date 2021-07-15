#!/bin/bash
sed -i 's|upstream_dns_file: ""|upstream_dns_file: /usr/local/AdGuardHome/upstream.txt|g' /usr/local/AdGuardHome/AdGuardHome.yaml
curl -o '/usr/local/bin/upstream.sh' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.sh'
chmod +x /usr/local/bin/upstream.sh
/usr/local/bin/upstream.sh
curl -o '/lib/systemd/system/upstream.service' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.service'
curl -o '/lib/systemd/system/upstream.timer' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.timer'
systemctl enable upstream.timer
systemctl start upstream.timer
systemctl status upstream
