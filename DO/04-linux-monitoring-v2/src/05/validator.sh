#!/bin/bash

check_sravnenie() {
    if [ $1 -ne $2 ]; then
        echo "Ошибка: Ожидалось $2 аргумента(ов), получено $1."
        return 1
    fi 
}

check_directory() {
    if [ ! -d $1 ]; then
        echo "Ошибка: указанная директория не существует."
        return 1
    fi
}

check_numeric() {
    if [[ ! $1 =~ ^[0-9]+$ ]]; then
        echo "Ошибка: $1 должно быть числом"
        return 1
    fi
}
check_alpha() {
    if [[ ! "$1" =~ ^[a-zA-Z]+$ ]]; then
        echo "Ошибка:$1 должно содержать только латинские буквы"
        return 1
    fi
}
check_not_alpha(){
       if [[ "$1" =~ ^[a-zA-Z]+$ ]]; then
        echo "Ошибка:$1 не должно содержать латинские буквы"
        return 1
    fi
}
check_gt() {
    if [ $1 -gt $2 ]; then
        echo "Ошибка: $1 не должно быть больше $2. Укажите параметр меньше $2"
        return 1
    fi
}

check_zero() {
    if [[ $* =~ (^|[[:space:]])0([[:space:]]|$) ]]; then
    echo "Ошибка: 0 не может быть указан в качестве параметра"
        return 1
    fi
}

check_permission() {
    if [ -w "$1" ]; then
        echo "Доступ на запись разрешена"
    else 
        echo "Ошибка: нет прав на запись в $1"
        exit 1
    fi
} 

check_dot() {
    if [[ ! $1 =~ \. ]]; then
        echo "Ошибка: в параметре $1 расширение должно быть отделено точкой (Пример: abc.txt)"
        return 1
    fi
}

check_kb() {
    if [[ ! $1 =~ ^[0-9]+([Kk][Bb]?|[Кк][Бб]?)?$ ]]; then
        echo "Ошибка: размер параметра $1 должен быть указан в Кб (Пример: 10Кб, 20К, 30)."
        return 1
    fi
}

check_space() {
    local free_space=$(df / | awk 'NR==2 {print $4}')
    if [ $free_space -lt 1048576 ]; then #1048576
    echo "Ошибка: мало места на диске (меньше 1 Гб)"
    return 1
    fi
}

check_empty_string() {
    if [ -z $1 ]; then
    echo "Ошибка: обнаружен пустой параметр"
    return 1
    fi
}

check_lt() {
    if [ $1 -lt $2 ]; then
        echo "Ошибка: $1 не должно быть меньше $2. Укажите параметр больше $2"
        return 1
    fi
}

check_mb() {
    if [[ ! $1 =~ ^[0-9]+([Mm][Bb]?|[Мм][Бб]?)?$ ]]; then
        echo "Ошибка: размер параметра $1 должен быть указан в Мб (Пример: 10Мб, 20М, 30)."
        return 1
    fi
}

check_interval(){
    if [ $1 -lt $2 ] || [ $1 -gt $3 ]; then
    echo "Ошибка: Значение $1 должно быть между $2 и $3"
    return 1
    fi
}

check_file() {
    if [ ! -f $1 ]; then
        echo "Ошибка: указанный файл не существует."
        return 1
    fi
}

check_datetime_format() {
    if date -d "$1" >/dev/null 2>&1; then
        return 0
    else
        echo "Указан неверный формат времени"
        return 1
    fi
}   

check_gt_alpha(){
    if [[ "$1" > "$2" ]]; then
        echo "Ошибка: "$1" должен быть меньше второго "$2""
        return 1
    fi
}

check_ne_pusto(){
    if [ ! -z $1 ]; then
        echo "Ошибка: параметр $1 должен быть пуст"
        return 1
    fi
}