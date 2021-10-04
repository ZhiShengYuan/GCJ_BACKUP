# AdGuardHome Upstream

[![LICENSE](https://img.shields.io/badge/LICENSE-BSD3%20Clause%20Liscense-brightgreen?style=flat-square)](./LICENSE)

This is the use of [felixonmars/dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list) on AdGuardHome. This project is based on whether NS is located in mainland China, and automatically collects all corresponding domain names and updates them to a list. And has the following features:

- Improve resolve speed for Chinese domains.
- Get the best CDN results.
- Prevent DNS poisoning.
- **Better than redir-host method.**

**In fact, for DNS resolution, when the domain's name server is in other region, even if the domain is resolved to an address in mainland China, we can still get the fastest resolution by DNS request from the other region in most cases.** And this list only includes domains that use domain name server from mainland China, that's why it is better than redir-host or any other similar methods. And caching, usually it brings a lot of problems. In fact, AdGuardHome has adopted optimistic caching since v0.107, which is much better than relying on upstream DNS caching.

## Steps for Usage

### Change settings

You need to change two options in `.../AdGuardHome.yaml` before you use and for your better experience. It is under the installation directory of AdGuardHome. If you don't remember your installation directory, you may be able to find it by `systemctl status AdGuardHome` or `service AdGuardHome status`. Usually, the installation directory of the old version is `/usr/local/AdGuardHome`, and the installation directory of the new version is `/opt/AdGuardHome`.

- The option `upstream_dns_file` must be `/usr/share/upstream.txt`.
- The option `all_servers` should be `true`.

### Get and run the script

At this step, there is the possibility of DNS failure, you need to clearly understand and pay attention to back up your DNS settings.

```
curl -o '/usr/local/bin/upstream.sh' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.sh'
chmod +x /usr/local/bin/upstream.sh
/usr/local/bin/upstream.sh
```

### Use systemd timer to automate

You can run the following code directly, or write it yourself by referring to this project, or just use crontab to automate it. What you need to pay attention to at this step is the connectivity between your network and raw.githubusercontent.com. If your network has this problem, you can try to manually copy to the directory below and continue, or try to use some CDN services.

```
curl -o '/lib/systemd/system/upstream.service' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.service'
curl -o '/lib/systemd/system/upstream.timer' 'https://raw.githubusercontent.com/fernvenue/adguard-home-upstream/master/upstream.timer'
systemctl enable upstream.timer
systemctl start upstream.timer
systemctl status upstream
```

## About AdGuardHome Config

For more information about AdGuardHome configuration, just read the official [AdGuardHome documentation](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration).
