# Level 14

Final level is mostly debugger control flow manipulation.

I used gdb to bypass anti-debug behavior and fake expected UID path:

```bash
gdb /bin/getflag
break ptrace
run
set $eax = 0
return
break getuid
continue
set $eax = 2014
finish
continue
```

If symbols or offsets differ on your build, just adjust breakpoint placement slightly.
