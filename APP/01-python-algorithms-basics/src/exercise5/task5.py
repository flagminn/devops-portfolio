def parse_float():
    s = input().strip()

    if not s:
        print('Incorrect input.')
        return

    sign = 1
    if s[0] == '-':
        sign = -1
        s = s[1:]
    elif s[0] == '+':
        s = s[1:]

    if not s or s == '.':
        print('Incorrect input.')
        return

    if '.' in s:
        parts = s.split('.')
        if len(parts) != 2:
            print('Incorrect input.')
            return
        p1, p2 = parts[0], parts[1]
    else:
        p1, p2 = s, ""

    nint = 0
    if p1:
        for char in p1:
            if not ord('0') <= ord(char) <= ord('9'):
                print('Incorrect input.')
                return
            nint = nint * 10 + (ord(char) - ord('0'))

    nfloat = 0.0
    if p2:
        for i, char in enumerate(p2):
            if not ord('0') <= ord(char) <= ord('9'):
                print('Incorrect input.')
                return
            nfloat += (ord(char) - ord('0')) * (10 ** -(i + 1))

    result = (nint + nfloat) * 2 * sign
    print(f'{result:.3f}')

parse_float()