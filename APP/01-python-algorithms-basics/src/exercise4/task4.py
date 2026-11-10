try:
    n = int(input())
    if n <= 0:
        print("Natural number was expected")
    else:
        l = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(i + 1):
                if i > 0 and j < i and j > 0:
                    p = l[i - 1][j - 1] + l[i - 1][j]
                else: 
                    p = 1
                
                l[i][j] = p

        for i in range(n):
            while 0 in l[i]:
                l[i].remove(0)
            print(*l[i])
            
except (ValueError):
    print("Natural number was expected")
