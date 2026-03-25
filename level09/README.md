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

Use printed output as next password.
