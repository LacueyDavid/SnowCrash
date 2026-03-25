# Level 02

This one is packet capture analysis.

Copy the pcap locally:

```bash
scp -P 4242 level02@<VM_IP>:/home/user/level02/level02.pcap .
```

Open it:

```bash
wireshark level02.pcap
```

Then follow the TCP stream. You see something like:

```text
ft_wandr...NDRel.L0L
```

The dots are DEL bytes in this context (0x7F), so they erase previous chars.

After replaying the typing with deletions, final password is:

```text
ft_waNDReL0L
```

Validate:

```bash
su flag02
# password: ft_waNDReL0L
getflag
```

unencrypted traffic leaks way more than people expect.
