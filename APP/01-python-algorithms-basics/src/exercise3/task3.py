sq, cr = 0, 0

with open('input.txt', 'r', encoding='utf-8') as file:
    l = file.read()

t = l.split('\n')

for i in range(len(t)):
    t[i] = t[i].split()
    for j in range(len(t[i])):
        t[i][j] = int(t[i][j])

for i in range(len(t)):
    for j in range(len(t[i])):
        up = t[i - 1][j] == 0 if i > 0 else True
        left = t[i][j - 1] == 0 if j > 0 else True
        down = t[i + 1][j] == 0 if i < len(t) - 1 else True
        right = t[i][j + 1] == 0 if j < len(t[i]) - 1 else True
        dia = t[i + 1][j - 1] == 0 if (i < len(t) - 1) and j > 0 else True
        updia = t[i - 1][j + 1] == 0 if i > 0 and j < len(t[i]) - 1 else True


        if t[i][j] == 1 and up and left and down == False and right == False and dia and updia:
            sq += 1
        elif t[i][j] == 0 and up and left and down == False and right == False:
            cr += 1


print(sq, cr)
