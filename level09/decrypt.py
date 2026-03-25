with open("./token", "rb") as f:
    data = f.read().strip()

decrypted = ""
for i, b in enumerate(data):
    decrypted += chr(b - i)

print(decrypted)
