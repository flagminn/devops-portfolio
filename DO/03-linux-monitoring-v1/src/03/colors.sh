#!/bin/bash

get_color() {
  local type=$1
  local color_num=$2
  local code=""

  case $color_num in
    1) code="7" ;;
    2) code="1" ;;
    3) code="2" ;;
    4) code="4" ;;
    5) code="5" ;;
    6) code="0" ;;
  esac

  if [ "$type" == "back" ]; then
    echo "4$code"
  else
    echo "3$code"
  fi
}

set_colors() {
  local L_B=$(get_color "back" $1)
  local L_F=$(get_color "font" $2)
  local R_B=$(get_color "back" $3)
  local R_F=$(get_color "font" $4)

  NC=$'\e[0m'
  LEFT_COLOR=$'\e['"${L_B};${L_F}m"
  RIGHT_COLOR=$'\e['"${R_B};${R_F}m"
}
