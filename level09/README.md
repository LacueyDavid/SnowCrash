# Level 09

Simple index-shift encoding.

Binary logic is:

```text
encoded[i] = original[i] + i
```

So decoding is:

```text
decoded[i] = encoded[i] - i
```

I used this script:

```python
with open("./token", "rb") as f:
    data = f.read().strip()

decrypted = ""
for i, b in enumerate(data):
    decrypted += chr(b - i)

print(decrypted)
```

Run:

```bash
python3 decrypt.py
```

I copied the `token` file from the SnowCrash VM with `scp`:

```bash
sudo scp -P 4242 level09@localhost:/home/user/level09/token .
```

Then I checked the file:

```bash
cat token
```

The content looks partially unreadable because it is encoded/binary-like data.

Finally I ran my decode script:

```bash
python3 decrypt.py
f3iji1ju5yuevaus41q1afiuq
```

then 

```bash
su flag09
getflag
```