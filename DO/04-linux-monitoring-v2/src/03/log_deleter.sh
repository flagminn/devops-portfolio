#!/bin/bash

log_deleter() {
    logfile="$1"
    if [ -z "$logfile" ]; then 
        read -p "Введите абсолютный путь к лог-файлу: " logfile
    fi
    check_file $logfile || { info; exit 1; }

    path_folder="$(awk '/папка/ {print $3}' "$logfile")" 
    path_file="$(awk '/файл/ {print $3}' "$logfile")"
    for path_file in $path_file; do
        if [ -e $path_file ]; then
            rm "$path_file"
            echo "Удален файл $path_file"
        fi
    done
    for path_folder in $path_folder; do
        if [ -e $path_folder ]; then
            rm -rf "$path_folder"
            echo "Удалена папка $path_folder "
        fi
    done
}
