n = int(input())
a = 0
t = n
while t > 0:
    a = a * 10 + (t % 10)
    t //= 10
print(a == n and n >= 0)
