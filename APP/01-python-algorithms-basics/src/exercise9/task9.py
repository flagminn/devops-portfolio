
n_str, x_str = input().split()
n = int(n_str)
x = float(x_str)

total_derivative = 0.0
current_power = n 


for _ in range(n + 1):
    coef = float(input())
    

    if current_power > 0:
        total_derivative += coef * current_power * (x ** (current_power - 1))
    
   
    current_power -= 1


print(f"{total_derivative:.3f}")