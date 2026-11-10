n = int(input())
c = 0
l = []
for i in range(n):
    x = int(input())
    c += 1 if x not in l else 0
    l.append(x)
print(c)

#Альтернативное решение( более экономичное по ресурсам компа)
# n = int(input())
# l = set()
# for i in range(n):
#     x = int(input())
#     l.add(x)
# print(len(l))