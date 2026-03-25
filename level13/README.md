# Level 13

Time for some binary exploitation! Decompiling the binary reveals a classic UID check against a hardcoded value:

```
0804859f        if (getuid() != 0x1092)
0804859f        {
080485ab            var_18 = 0x1092;
080485ba            printf("UID %d started us but we we expect %d\n", getuid(), 0x1092);
080485c6            exit(1);
0804859f        }
080485e9        return printf("your token is %s\n",
080485e9            ft_des("boe]!ai0FB@.:|L6l@A?>qJ}I"), var_18);
```

The binary expects UID `0x1092` (4242 in decimal). If the check passes, it decrypts and prints the token. We need to fake the return value of `getuid()` to bypass it.

On x86, function return values are stored in the `eax` register. The trick is to let `getuid()` finish executing, then overwrite `eax` before the comparison reads it. We can do exactly that with GDB's `finish` command:

```bash
gdb ./level13
break getuid
run
finish        # step out of getuid, landing right before the comparison
set $eax = 0x1092
continue
```

`finish` executes the rest of `getuid` and breaks immediately upon returning to `main`, so our fake value is in place before anything can overwrite it.
