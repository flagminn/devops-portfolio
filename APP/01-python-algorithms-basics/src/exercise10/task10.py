
try:
    first_line = input().split()
    if len(first_line) != 2:
        raise ValueError
    
    n, target_time = int(first_line[0]), int(first_line[1])
    if n <= 0 or target_time <= 0:
        raise ValueError

    devices = []
    
    for _ in range(n):
        line = input().split()
        if len(line) != 3:
            raise ValueError
        
        year, cost, time = int(line[0]), int(line[1]), int(line[2])
        if year <= 0 or cost <= 0 or time <= 0:
            raise ValueError
            
        devices.append({"year": year, "cost": cost, "time": time})

    min_total_cost = float('inf')

    for i in range(n):
        for j in range(i + 1, n):
            dev1 = devices[i]
            dev2 = devices[j]
            
            if dev1["year"] == dev2["year"] and (dev1["time"] + dev2["time"] == target_time):
                current_cost = dev1["cost"] + dev2["cost"]
                if current_cost < min_total_cost:
                    min_total_cost = current_cost

    if min_total_cost != float('inf'):
        print(min_total_cost)
    else:
        print("Ошибка")

except (ValueError, IndexError, TypeError):
    print("Ошибка")