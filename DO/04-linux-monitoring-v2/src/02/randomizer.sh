#!/bin/bash
random_f() {
    mapfile -t folders_list < <(find / -type d \( -path "/bin*" -o -path "/sbin*" -o -path "/proc*" -o -path "/dev*" -o -path "/sys*" \) -prune -o -type d -writable -print 2>/dev/null | shuf -n 100)
    mapfile -t random_files < <(shuf -i 1-100 -n 100)
}
