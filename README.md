# AdGuardHome Upstream

[![LICENSE](https://img.shields.io/badge/LICENSE-BSD3%20Clause%20Liscense-brightgreen?style=flat-square)](./LICENSE)

This is the use of [dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list) on AdGuardHome.

- Improve resolve speed for Chinese domains.
- Get the best CDN results.
- Prevent DNS poisoning.


## Quick Start

You should be installed and able to use [curl](https://curl.se/) and [sed](https://www.gnu.org/software/sed/manual/sed.html).

```
bash <(wget -qO- 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/QuickStart.sh')
```

## Steps for Usage

First of all, you must change the setting to use upstream file.

Find the option `upstream_dns_file` in `/usr/local/AdGuardHome/AdGuardHome.yaml`,<br>
And it should be `/usr/local/AdGuardHome/upstream.txt`.<br>

Get and run the script.

```
curl -o '/usr/local/bin/upstream.sh' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.sh'
chmod +x /usr/local/bin/upstream.sh
/usr/local/bin/upstream.sh
```

Use systemd timer to run automatically.

```
curl -o '/lib/systemd/system/upstream.service' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.service'
curl -o '/lib/systemd/system/upstream.timer' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.timer'
systemctl enable upstream.timer
systemctl start upstream.timer
systemctl status upstream
```

## About AdGuardHome Config

For more information about AdGuardHome configuration, please read the official [AdGuardHome documentation](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration).
