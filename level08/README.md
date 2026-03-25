# Level 08

The binary blocks any argument containing token.

Direct try fails:

```bash
./level08 token
```

But the check is only on the string you pass, so symlink wins:

```bash
ln -sf /home/user/level08/token /tmp/tok
./level08 /tmp/tok
```

You still read the real file, while bypassing the naive string filter.
