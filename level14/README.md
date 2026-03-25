# Level 14

Really funny final level, it's mostly debugger control flow manipulation.

I used gdb to bypass anti-debug behavior and fake expected UID path:

```bash
gdb /bin/getflag
break ptrace
break getuid
run

finish
set $eax = 0
continue

finish
set $eax = 3014
continue
```

If symbols or offsets differ on your build, just adjust breakpoint placement slightly.
