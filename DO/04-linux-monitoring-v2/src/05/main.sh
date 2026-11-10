#!/bin/bash
. ./validator.sh
. ./sort.sh

info(){
    echo "Запустите программу с 1 параметром из предложенных"
    echo "1. Вывод запросов отсортированных по коду ответа;"
    echo "2. Вывод всех уникальных IP, встречающихся в записях;"
    echo "3. Вывод всех запросов с ошибками (код ответа — 4хх или 5хх);"
    echo "4. Вывод всех уникальных IP, которые встречаются среди ошибочных запросов."
}

check_sravnenie $# 1 || { info; exit 1; }
check_numeric $1 || { info; exit 1; }

logfile=( "../04/log_1_2026-03-24.log" "../04/log_2_2026-03-25.log" "../04/log_3_2026-03-26.log" "../04/log_4_2026-03-27.log" "../04/log_5_2026-03-28.log" )



case $1 in

    1) 
    code_sort
    code_sort > result_code_sort
    echo "Работа завершена. Результаты выполнения скрипта сохранены в result_code_sort"
    ;;
    2) ip_sort
    ip_sort > result_ip_sort
    echo "Работа завершена. Результаты выполнения скрипта сохранены в result_ip_sort"
    ;;
    3) error_sort
    error_sort > result_error_sort
    echo "Работа завершена. Результаты выполнения скрипта сохранены в result_error_sort"
    ;;
    4) ip_error_sort
    ip_error_sort > result_ip_error_sort
    echo "Работа завершена. Результаты выполнения скрипта сохранены в result_ip_error_sort"
    ;;
    *)
    echo "Ошибка, указан неизвестный параметр"
    info
    exit 1
    ;;
esac

