# Level00

```
level00@SnowCrash:~$ find / -user flag00 2> /dev/null
/usr/sbin/john
/rofs/usr/sbin/john
```

```
level00@SnowCrash:~$ cat /usr/sbin/john
cdiiddwpgswtgt
```

With the help of this [decoder](https://dencode.com/en/), I was able to find with algorithm this was.

Which is `nottoohardhere`
