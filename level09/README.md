# Level09

The binary `level09` encodes a string using an index-based shift cipher:

```
encoded[i] = original[i] + i
```

Run the binary to see it in action:

```bash
./level09 abcd
# outputs: aceg
```

The token file contains the **already encoded** password, so we need to reverse it by subtracting the index from each character:

```python
with open("./token", "rb") as f:
    data = f.read().strip()

decrypted = ""
for i, b in enumerate(data):
    decrypted += chr(b - i)

print(decrypted)
```

Run it by passing the token content as an argument:

```bash
python3 decode.py $(cat ./token)
```

This gives you the plaintext password for the next level.
