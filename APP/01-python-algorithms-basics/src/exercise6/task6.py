import json

try:
    with open('input.txt', 'r', encoding='utf-8') as file:
        f = file.read()
        
    if not f.strip():
        print('Empty file')
    else:
        data = json.loads(f) 
        l = data["list1"] + data["list2"]
        res = sorted(l, key=lambda movie: movie["year"])
        output = {"list0": res}
        print(json.dumps(output, indent=2))


except FileNotFoundError:
    print('Ошибка: файл не найден')

except json.JSONDecodeError:
    print('Ошибка: Некорректный формат JSON')

except KeyError:
    print('Ошибка: В файле нет нужных списков фильмов')

except TypeError:
    print('Ошибка типов данных')