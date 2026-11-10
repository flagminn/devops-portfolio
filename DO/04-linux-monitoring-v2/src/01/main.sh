#!/bin/bash
source ./validator.sh
. ./generator.sh

path="$1"
folders="$2"
chars_folders="$3"
files="$4"
chars_files="$( echo $5 | cut -d '.' -f1)"
ext_files="$( echo $5 | cut -d '.' -f2)"
size="$( echo $6 | grep -o -E '[0-9]+')"

check_sravnenie $# 6 || exit 1
check_directory $path || exit 1
check_numeric $folders || exit 1
check_numeric $files || exit 1
check_numeric $size || exit 1
check_alpha $chars_files || exit 1
check_alpha $chars_folders || exit 1
check_gt ${#chars_folders} 7 || exit 1
check_gt ${#chars_files} 7 || exit 1
check_gt ${#ext_files} 3 || exit 1
check_gt $size 100 || exit 1
check_zero $* || exit 1
check_permission $path || exit 1
check_dot $5 || exit 1
check_kb $6 || exit 1
check_empty_string $ext_files || exit 1

generator