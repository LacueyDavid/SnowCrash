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
import sys
hash = sys.argv[1]
decrypted_hash = ""
for i in range(0, len(hash)):
    decrypted_hash = decrypted_hash + chr(ord(hash[i]) - i)
print(decrypted_hash)
```

Run it by passing the token content as an argument:

```bash
python3 decode.py $(cat ./token)
```

This gives you the plaintext password for the next level.
