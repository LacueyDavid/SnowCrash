
str = open("token").read()
count = 0
a = []
for i in str:
    a.append(ord(i) - count)
    count += 1
str = "".join(chr(x) for x in a)
with open("token", "w") as f:
    f.write(str)
