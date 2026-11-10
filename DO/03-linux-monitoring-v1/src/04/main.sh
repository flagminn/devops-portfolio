#!/bin/bash

. "$(dirname "$0")/info.sh"
. "$(dirname "$0")/colors.sh"

CONFIG_FILE="$(dirname "$0")/settings.conf"

D_B1=6; D_F1=1; D_B2=2; D_F2=4

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
fi

B1=${column1_background:-$D_B1}
F1=${column1_font_color:-$D_F1}
B2=${column2_background:-$D_B2}
F2=${column2_font_color:-$D_F2}

if [ "$B1" == "$F1" ] || [ "$B2" == "$F2" ]; then
    echo "Error: Background and font colors must not match in config."
    exit 1
fi

set_colors "$B1" "$F1" "$B2" "$F2"

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

echo

show_conf_line() {
    local label=$1
    local val=$2
    local def=$3
    if [ -z "$val" ] || [ "$val" == "$def" ]; then
        echo "$label = default ($(get_color_name $def))"
    else
        echo "$label = $val ($(get_color_name $val))"
    fi
}

show_conf_line "Column 1 background" "${column1_background}" "$D_B1"
show_conf_line "Column 1 font color" "${column1_font_color}" "$D_F1"
show_conf_line "Column 2 background" "${column2_background}" "$D_B2"
show_conf_line "Column 2 font color" "${column2_font_color}" "$D_F2"
