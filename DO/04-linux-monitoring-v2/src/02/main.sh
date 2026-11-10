#!/bin/bash
source ./validator.sh
. ./generator.sh
. ./randomizer.sh


chars_folders="$1"
chars_files="$( echo $2 | cut -d '.' -f1)"
ext_files="$( echo $2 | cut -d '.' -f2)"
size="$( echo $3 | grep -o -E '[0-9]+')"

check_sravnenie $# 3 || exit 1


check_numeric $size || exit 1
check_alpha $chars_files || exit 1
check_alpha $chars_folders || exit 1
check_gt ${#chars_folders} 7 || exit 1
check_gt ${#chars_files} 7 || exit 1
check_gt ${#ext_files} 3 || exit 1
check_gt $size 100 || exit 1
check_zero $* || exit 1
check_dot $2 || exit 1
check_mb $3 || exit 1
check_empty_string $ext_files || exit 1

random_f
generator