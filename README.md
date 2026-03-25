# SnowCrash

This repo is my full SnowCrash walkthrough, level by level.

The idea is always the same:

1. log in
2. find what is broken
3. abuse it
4. grab the password for the next level

I kept the notes practical on purpose: what I checked, what worked, and why it worked.

## What this project teaches

- Linux internals and permissions
- SUID/SGID abuse patterns
- weak crypto / weak hashing pitfalls
- command injection and bad shell usage
- binary debugging with gdb

## Quick start

```bash
ssh level00@<VM_IP> -p 4242
# initial password
level00
```

Then just follow each level folder from 00 to 14.

## Structure

- level00 -> level14: one write-up per level
- flagXX.txt: token traces / notes
- helper scripts when needed (example: level09/decrypt.py)

## Important

This is educational content for legal lab usage only.
