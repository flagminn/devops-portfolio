#!/bin/bash

mask_deleter(){
    user_mask="$1"
    if [ -z "$user_mask" ]; then
        read -p "Введите маску (буквы используемые при генерации): " user_mask
    fi
    check_alpha "$user_mask" || exit 1
    mask="*${user_mask}_[0-9][0-9][0-9][0-9][0-9][0-9]*"

    mapfile -t mask_list < <(find / \( -path "/bin*" -o -path "/sbin*" -o -path "/sys*" -o -path "/dev*" -o -path "/proc*" \) -prune -o \
    -name "$mask" -print 2>/dev/null)

    for item in "${mask_list[@]}"; do
        if [ -e "${item}" ] && [ -n "${item}" ]; then
            rm -rf "$item"
            echo "Удалено "$item""
        fi
    done
}
