n, m = map(int, input().split())
l = []

for _ in range(n):
    l.append(list(map(int, input().split())))

for i in range(1, n):
    l[i][0] += l[i - 1][0]
for i in range(1, m):
    l[0][i] += l[0][i - 1]

for x in range(1, n):
    for y in range(1, m):
        l[x][y] += max(l[x - 1][y], l[x][y - 1])

print(l[n - 1][m - 1])
