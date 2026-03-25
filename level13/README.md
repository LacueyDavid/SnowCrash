# Level 13

This is a UID check bypass with gdb.

Program expects UID 4242, otherwise exits.

So I forced getuid return value in eax right before comparison:

```bash
gdb ./level13
break getuid
run
finish
set $eax = 4242
continue
```

On x86, eax stores function return values, so this bypasses the UID check and prints the token.
