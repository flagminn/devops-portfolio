import asyncio
import os
import aiohttp
from urllib.parse import urlparse

def get_valid_path():
    while True:
        path = input("Введите путь для сохранения изображений: ").strip()
        if not path:
            print("Путь не может быть пустым. Попробуйте еще раз.")
            continue
        
        if not os.path.exists(path):
            try:
                os.makedirs(path, exist_ok=True)
            except Exception:
                print(f"Не удалось создать директорию по пути '{path}'. Введите другой путь.")
                continue
                
        if os.access(path, os.W_OK):
            return path
        else:
            print(f"Нет прав на запись по пути '{path}'. Введите другой путь.")

async def download_image(session, url, save_path, results):
    try:
        parsed_url = urlparse(url)
        filename = os.path.basename(parsed_url.path)
        if not filename or '.' not in filename:
            filename = f"image_{int(asyncio.get_event_loop().time())}.jpg"
            
        full_path = os.path.join(save_path, filename)
        
        async with session.get(url, timeout=10) as response:
            if response.status == 200:
                content = await response.read()
                
                def save_file():
                    with open(full_path, 'wb') as f:
                        f.write(content)
                
                await asyncio.to_thread(save_file)
                results.append((url, "Успех"))
            else:
                results.append((url, "Ошибка"))
    except Exception:
        results.append((url, "Ошибка"))

def print_summary(results):
    print("Сводка об успешных и неуспешных загрузках")
    if not results:
        print("Список загрузок пуст.")
        return

    max_url_len = max(len(res[0]) for res in results)
    max_url_len = max(max_url_len, 56)
    
    border = f"+-{'-' * max_url_len}-+--------+"
    header = f"| {'Ссылка':<{max_url_len}} | Статус |"
    
    print(border)
    print(header)
    print(border)
    for url, status in results:
        print(f"| {url:<{max_url_len}} | {status:^6} |")
    print(border)

async def main():
    save_path = get_valid_path()
    
    results = []
    tasks = []
    
    async with aiohttp.ClientSession() as session:
        while True:
            url = await asyncio.to_thread(input, "Введите ссылку на изображение (или пустую строку для выхода): ")
            url = url.strip()
            
            if url == "":
                break
                
            task = asyncio.create_task(download_image(session, url, save_path, results))
            tasks.append(task)
            
        unfinished_tasks = [t for t in tasks if not t.done()]
        if unfinished_tasks:
            print("Ожидание завершения оставшихся загрузок...")
            await asyncio.gather(*tasks)
            
    print()
    print_summary(results)

if __name__ == '__main__':
    asyncio.run(main())