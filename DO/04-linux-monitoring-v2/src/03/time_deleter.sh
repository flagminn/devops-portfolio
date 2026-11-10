#!/bin/bash
time_deleter() {
    time_start="$1"
    time_end="$2"
    
    if [ -z "$time_start" ]; then 
        read -p "Введите начальное значение временного диапазона (в формате ГГГГ-ММ-ДД ЧЧ:ММ): " time_start
    fi
    if [ -z "$time_end" ]; then 
        read -p "Введите конечное значение временного диапазона (в формате ГГГГ-ММ-ДД ЧЧ:ММ): " time_end
    fi
    
    check_datetime_format "$time_start" || exit 1
    check_datetime_format "$time_end" || exit 1
    check_gt_alpha "$time_start" "$time_end" || exit 1
    check_not_alpha "$time_start" || exit 1
    check_not_alpha "$time_end" || exit 1


    mapfile -t time_list < <(find / -mindepth 2 \( -path "/bin*" -o -path "/sbin*" -o -path "/sys*" -o -path "/dev*" -o -path "/proc*" \) -prune -o \
    -type f -newermt "$time_start" ! -newermt "$time_end" -print 2>/dev/null)
    for item in ${time_list[@]}; do
        if [ -f "$item" ]; then
            rm -f "$item"
            echo "Удалено "$item""
        fi
    done 
    find / -maxdepth 5 \( -path "/bin*" -o -path "/sbin*" -o -path "/sys*" -o -path "/dev*" -o -path "/proc*" \) -prune -o \
-type d -empty -delete 2>/dev/null
}
