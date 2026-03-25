# Level 01

Here the trick is the password hash in /etc/passwd.

```bash
cat /etc/passwd
```

Relevant line:

```text
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
```

I extracted the hash and gave it to John:

```bash
echo '42hDRfypTqqnw' > passwd.hash
john passwd.hash
john --show passwd.hash
```

Recovered password:

```text
abcdefg
```

Then:

```bash
su flag01
# password: abcdefg
getflag
```

weak password + old hash format situation.
