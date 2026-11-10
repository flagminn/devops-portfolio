import random, time, math
from multiprocessing import Process, Queue, Manager

with open('examiners.txt', 'r', encoding='UTF-8') as file_examiners:
    examiners = file_examiners.readlines()
with open('students.txt', 'r', encoding='UTF-8') as file_students:
    students = file_students.readlines()
with open('questions.txt', 'r', encoding='UTF-8') as file_questions:
    questions_lines = [line.strip() for line in file_questions if line.strip()]

def mood():
    mn = random.randint(1, 8)
    return "Плохое" if mn == 1 else "Хорошее" if mn >= 7 else "Нейтральное"

class Examiner:
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender
        self.mood = mood()        
        self.worktime = random.uniform(len(name) - 1, len(name) + 1)

class Student:
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender

class Question:
    def __init__(self, text):
        self.text = text

examiners_list = [Examiner(line.split()[0], line.split()[1]) for line in examiners]
students_list = [Student(line.split()[0], line.split()[1]) for line in students]
questions_list = [Question(line) for line in questions_lines]

def student_answer(quest, gender):
    f = (1 + math.sqrt(5)) / 2
    probabilities = []
    remainder = 1.0
    for i in range(len(quest)):
        if i == len(quest) - 1:
            probabilities.append(remainder)
        else:
            current_prob = remainder / f
            probabilities.append(current_prob)
            remainder -= current_prob
    words = quest if gender == 'М' else quest[::-1]
    return random.choices(words, weights=probabilities, k=1)[0]
   
def exam_run(examiner, student_queue, shared_table, shared_questions, start_time):
    had_lunch = False   
    
    while True:
        current_time = time.time()
        if not had_lunch and (current_time - start_time >= 30):
            data = shared_table[examiner.name]
            data['status'] = 'Lunch'
            shared_table[examiner.name] = data
            time.sleep(random.uniform(12, 18))
            had_lunch = True

        data = shared_table[examiner.name]
        data['status'] = 'Waiting'
        data['current_student'] = ''
        shared_table[examiner.name] = data

        student = student_queue.get()
        if student is None:
            break
        
        data = shared_table[examiner.name]
        data['status'] = 'Exam'
        data['current_student'] = student.name
        data['total_students'] += 1
        shared_table[examiner.name] = data

        shared_table[student.name] = 'Сдает'

        score = 0
        for _ in range(3):
            q_obj = random.choice(questions_list)
            quest = q_obj.text.split()    
            correct_answer = []
            ans_count = 1
            while ans_count == 1:   
                word = random.choice(quest)
                if word not in correct_answer:
                    correct_answer.append(word)
                ans_count = random.randint(1, 3)
            
            if student_answer(quest, student.gender) in correct_answer:
                score += 1
                shared_questions[q_obj.text] += 1
            else:
                score -= 1
        
        time.sleep(examiner.worktime)
    
        if examiner.mood == 'Хорошее': mark = 'Сдал'
        elif examiner.mood == 'Плохое': mark = 'Провалил'
        else: mark = 'Сдал' if score > 0 else 'Провалил'
        
        end_time = time.time() - start_time
        shared_table[student.name] = {
            'status': mark, 'worktime': examiner.worktime, 'end_time': end_time
        }

        if mark == 'Провалил':
            data = shared_table[examiner.name]
            data['failed_students'] += 1
            shared_table[examiner.name] = data

def draw_dashboard(shared_table, examiners_list, students_list, start_time):
    elapsed_time = time.time() - start_time
    in_queue = sum(1 for k, v in shared_table.items() if v == 'Waiting' or v == 'Сдает')
    
    print("\033[H", end="")
    print("Во время работы")
    
    print("+------------+----------+")
    print("| Студент    |  Статус  |")
    print("+------------+----------+")
    
    def student_sort_key(item):
        name, val = item
        if name in [e.name for e in examiners_list] or name == "PROCESSED_QUESTIONS": return (9, name)
        if val == 'Waiting' or val == 'Сдает': return (0, name)
        if isinstance(val, dict) and val['status'] == 'Сдал': return (1, name)
        return (2, name)
        
    for key, value in sorted(shared_table.items(), key=student_sort_key):
        if key in [e.name for e in examiners_list] or key == "PROCESSED_QUESTIONS": continue
        
        if value == 'Waiting' or value == 'Сдает': 
            status_str = "Очередь"
        elif isinstance(value, dict) and value['status'] == 'Сдал': 
            status_str = "Сдал"
        else: 
            status_str = "Провалил"
            
        print(f"| {key:<10} | {status_str:^8} |")
        
    print("+------------+----------+\n")

    print("+-------------+-----------------+-----------------+---------+--------------+")
    print("| Экзаменатор | Текущий студент | Всего студентов | Завалил | Время работы |")
    print("+-------------+-----------------+-----------------+---------+--------------+")
    
    for ex in examiners_list:
        data = shared_table[ex.name]
        if data['status'] == 'Exam':
            curr_stud = data['current_student']
        else:
            curr_stud = "-"
            
        total_stud = data.get('total_students', 0)
        failed_stud = data['failed_students']
        current_worktime = total_stud * ex.worktime
        
        print(f"| {ex.name:<11} | {curr_stud:<15} | {total_stud:^15} | {failed_stud:^7} | {current_worktime:^12.2f} |")
        
    print("+-------------+-----------------+-----------------+---------+--------------+\n")
    
    print(f"Осталось в очереди: {in_queue} из {len(students_list)}")
    print(f"Время с момента начала экзамена: {elapsed_time:.2f}")
    print("\033[J", end="")

def show_final_stats(shared_table, shared_questions, examiners_list, students_list, total_time):
    print("\033[H\033[J", end="")
    print("После работы")
    
    passed = {k: v for k, v in shared_table.items() if isinstance(v, dict) and v['status'] == 'Сдал'}
    failed = {k: v for k, v in shared_table.items() if isinstance(v, dict) and v['status'] == 'Провалил'}
    
    print("+------------+----------+")
    print("| Студент    |  Статус  |")
    print("+------------+----------+")
    
    def final_student_sort(item):
        name, val = item
        if name in [e.name for e in examiners_list] or name == "PROCESSED_QUESTIONS": return (9, name)
        if isinstance(val, dict) and val['status'] == 'Сдал': return (0, name)
        return (1, name)
        
    for key, value in sorted(shared_table.items(), key=final_student_sort):
        if key in [e.name for e in examiners_list] or key == "PROCESSED_QUESTIONS": continue
        status_str = "Сдал" if isinstance(value, dict) and value['status'] == 'Сдал' else "Провалил"
        print(f"| {key:<10} | {status_str:^8} |")
        
    print("+------------+----------+\n")

    print("+-------------+-----------------+---------+--------------+")
    print("| Экзаменатор | Всего студентов | Завалил | Время работы |")
    print("+-------------+-----------------+---------+--------------+")
    
    for ex in examiners_list:
        data = shared_table[ex.name]
        total_stud = data.get('total_students', 0)
        failed_stud = data['failed_students']
        current_worktime = total_stud * ex.worktime
        
        print(f"| {ex.name:<11} | {total_stud:^15} | {failed_stud:^7} | {current_worktime:^12.2f} |")
        
    print("+-------------+-----------------+---------+--------------+\n")

    if passed:
        min_worktime = min(s['worktime'] for s in passed.values())
        best_students = [k for k, s in passed.items() if s['worktime'] == min_worktime]
    else:
        best_students = ["Нет"]

    if failed:
        min_end_time = min(s['end_time'] for s in failed.values())
        expelled_students = [k for k, s in failed.items() if s['end_time'] == min_end_time]
    else:
        expelled_students = ["Нет"]

    ex_rates = {}
    for ex in examiners_list:
        data = shared_table[ex.name]
        total = data.get('total_students', 0)
        rate = (data['failed_students'] / total) if total > 0 else 0
        ex_rates[ex.name] = rate
    
    min_rate = min(ex_rates.values()) if ex_rates else 0
    best_examiners = [k for k, v in ex_rates.items() if v == min_rate]

    max_ans = max(shared_questions.values()) if shared_questions.values() else 0
    best_questions = [k for k, v in shared_questions.items() if v == max_ans and max_ans > 0]
    if not best_questions:
        best_questions = ["Ни один вопрос не отвечен верно"]

    success_percent = (len(passed) / len(students_list)) * 100
    exam_result = "экзамен удался" if success_percent > 85 else "экзамен не удался"

    print(f"Время с момента начала экзамена и до момента и его завершения: {total_time:.2f}")
    print(f"Имена лучших студентов: {', '.join(best_students)}")
    print(f"Имена лучших экзаменаторов: {', '.join(best_examiners)}")
    print(f"Имена студентов, которых после экзамена отчислят: {', '.join(expelled_students)}")
    print(f"Лучшие вопросы: {', '.join(best_questions)}")
    print(f"Вывод: {exam_result}")

if __name__ == '__main__':
    print("\033[H\033[J", end="")
    
    student_queue = Queue()
    manager = Manager()
    shared_table = manager.dict()
    shared_questions = manager.dict()

    for q in questions_list: shared_questions[q.text] = 0
    
    for s in students_list:
        student_queue.put(s)
        shared_table[s.name] = 'Waiting'
        
    for ex in examiners_list:
        shared_table[ex.name] = {
            'status': 'Waiting', 'current_student': '', 'failed_students': 0, 'total_students': 0
        }
        
    for _ in range(len(examiners_list)): student_queue.put(None)
    
    start_time = time.time()
    processes = [Process(target=exam_run, args=(ex, student_queue, shared_table, shared_questions, start_time)) for ex in examiners_list]
    for p in processes: p.start()

    while any(p.is_alive() for p in processes):
        draw_dashboard(shared_table, examiners_list, students_list, start_time)
        time.sleep(1)
    
    for p in processes: p.join()
    
    total_time = time.time() - start_time
    show_final_stats(shared_table, shared_questions, examiners_list, students_list, total_time)