#!/bin/bash

. "$(dirname "$0")/info.sh"
. "$(dirname "$0")/colors.sh"

if [ "$#" -ne 4 ]; then
    echo "Error: Exactly 4 parameters required (1-6)."
    exit 1
fi

for arg in "$@"; do
    if [[ ! $arg =~ ^[1-6]$ ]]; then
        echo "Error: Parameters must be numbers from 1 to 6."
        exit 1
    fi
done

if [ "$1" == "$2" ] || [ "$3" == "$4" ]; then
    echo "Error: Background and font colors must not match. Restart the script."
    exit 1
fi

set_colors "$1" "$2" "$3" "$4"

print_colored() {
    echo -e "${LEFT_COLOR}${1}${NC} = ${RIGHT_COLOR}${2}${NC}"
}

print_colored "HOSTNAME" "$HOSTNAME"
print_colored "TIMEZONE" "$TIMEZONE"
print_colored "USER" "$USER"
print_colored "OS" "$OS"
print_colored "DATE" "$DATE"
print_colored "UPTIME" "$UPTIME"
print_colored "UPTIME_SEC" "$UPTIME_SEC"
print_colored "IP" "$IP"
print_colored "MASK" "$MASK"
print_colored "GATEWAY" "$GATEWAY"
print_colored "RAM_TOTAL" "$RAM_TOTAL"
print_colored "RAM_USED" "$RAM_USED"
print_colored "RAM_FREE" "$RAM_FREE"
print_colored "SPACE_ROOT" "$SPACE_ROOT"
print_colored "SPACE_ROOT_USED" "$SPACE_ROOT_USED"
print_colored "SPACE_ROOT_FREE" "$SPACE_ROOT_FREE"
