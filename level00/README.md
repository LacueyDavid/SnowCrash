# Level 00

Pretty chill first level.

I searched for files owned by flag00:

```bash
find / -user flag00 2>/dev/null
```

One useful file was:

```text
/usr/sbin/john
```

Then:

```bash
cat /usr/sbin/john
```

Output:

```text
cdiiddwpgswtgt
```

That string is just a ROT shift. Decoding gives:

```text
nottoohardhere
```

Use it:

```bash
su flag00
# password: nottoohardhere
getflag
```

weak obfuscation is not security.
