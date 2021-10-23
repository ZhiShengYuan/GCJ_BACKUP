# AdGuardHome Upstream

[![LICENSE](https://img.shields.io/badge/LICENSE-BSD3%20Clause%20Liscense-brightgreen?style=flat-square)](./LICENSE)

This is the use of [felixonmars/dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list) on AdGuardHome, it is an automated collection project that collects all domain names in mainland China, based on the location of NS. It has the following features:

- Improve resolve speed for Chinese domains.
- Get the best CDN results.
- Prevent DNS poisoning.
- **Better than redir-host method.**

**In fact, for DNS resolution, when the domain's name server is in other region, even if the domain is resolved to an address in mainland China, we can still get the fastest resolution by DNS request from the other region in most cases.** And this list only includes domains that use domain name server from mainland China, that's why it is better than redir-host or any other similar methods. You might say that some DNS servers have caches, usually it brings a lot of problems. In fact, AdGuardHome has adopted optimistic caching since v0.107, which is much better than relying on upstream DNS caching.

## Steps for Usage

### Change settings

You need to change two options in `.../AdGuardHome.yaml` before you use and for your better experience. It is under the installation directory of AdGuardHome. If you don't remember your installation directory, you may be able to find it by `systemctl status AdGuardHome` or `service AdGuardHome status`. Usually, the installation directory of the old version is `/usr/local/AdGuardHome`, and the installation directory of the new version is `/opt/AdGuardHome`.

- The option `upstream_dns_file` must be `/usr/share/upstream.txt`.
- The option `all_servers` should be `true`.

### Get and run the script

At this step, there is the possibility of DNS failure, you need to clearly understand and pay attention to back up your DNS settings.

```
curl -o '/usr/local/bin/upstream.sh' 'https://cdn.jsdelivr.net/gh/fernvenue/adguard-home-upstream/upstream.sh'
chmod +x /usr/local/bin/upstream.sh
/usr/local/bin/upstream.sh
```
If you use **openwrt or other non-systemd Linux** system, you have to change the last line `systemctl restart AdGuardHome` to `/etc/init.d/AdGuardHome restart`.

### Use systemd timer to automate

You can run the following code directly, or write it yourself by referring to this project, or just use crontab to automate it.

```
curl -o '/lib/systemd/system/upstream.service' 'https://cdn.jsdelivr.net/gh/fernvenue/adguard-home-upstream/upstream.service'
curl -o '/lib/systemd/system/upstream.timer' 'https://cdn.jsdelivr.net/gh/fernvenue/adguard-home-upstream/upstream.timer'
systemctl enable upstream.timer
systemctl start upstream.timer
systemctl status upstream
```

If you use **openwrt or other non-systemd Linux** system, you can just use crontab to automate it: `0 5 * * * /usr/local/bin/upstream.sh`.

## Something else

If you use the upstream suggested by this project, you need to know that they have already configured a certificate for the IP address, and you **DO NOT** need to use a configuration such as `dns.google`. It is also strongly not recommended for you to do this, it will bring efficiency and safety issues. Wouldn't it be great to not need to resolve the addresses of the DNS servers? In fact, I can’t understand why some people choose domain names instead of IP addresses. I couldn’t believe it when I met such a person.

## About AdGuardHome Config

For more information about AdGuardHome configuration, just read the official [AdGuardHome documentation](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration).
