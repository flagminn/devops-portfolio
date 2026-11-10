s1, s2 = input().split(), input().split()
for i in range(3):
    s1[i] = float(s1[i])
    s2[i] = float(s2[i])
print(s1[0] * s2[0] + s1[1] * s2[1] + s1[2] * s2[2])

