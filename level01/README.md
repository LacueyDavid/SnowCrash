# Level01

```
flag01@SnowCrash:~$ cat /etc/passwd | grep flag01
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
```

Copy `42hDRfypTqqnw`

```
echo 42hDRfypTqqnw > passwd.txt
❯ john --show passwd.txt
?:abcdefg

1 password hash cracked, 0 left
```
