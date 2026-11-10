#!/bin/bash

cdr2mask() {
  local i mask=""
  local full_octets=$(($1 / 8))
  local partial_octet=$(($1 % 8))

  for ((i=0; i<4; i++)); do
    if [ $i -lt $full_octets ]; then
      mask+=255
    elif [ $i -eq $full_octets ]; then
       mask+=$((256 - 2**(8 - $partial_octet)))
    else
      mask+=0
    fi
    [ $i -lt 3 ] && mask+=.
  done
  echo "$mask"
}

HOSTNAME=$(hostname)
TIMEZONE="$(cat /etc/timezone) $(date +'%Z %-z')"
USER=$(whoami)
OS=$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2) # Чисто стандартный grep/cut
DATE=$(date +"%d %b %Y %H:%M:%S")
UPTIME=$(uptime -p)
UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)

IP_INFO=$(ip -4 addr show scope global | awk '/inet / {print $2; exit}')
IP=$(echo $IP_INFO | cut -d/ -f1)
CIDR=$(echo $IP_INFO | cut -d/ -f2)
MASK=$(cdr2mask $CIDR)

GATEWAY=$(ip route | grep default | awk '{print $3}')

RAM_TOTAL=$(free -m | awk '/Mem:/{printf "%.3f GB", $2/1024}')
RAM_USED=$(free -m | awk '/Mem:/{printf "%.3f GB", $3/1024}')
RAM_FREE=$(free -m | awk '/Mem:/{printf "%.3f GB", $4/1024}')

SPACE_ROOT=$(df -m / | awk 'NR==2{printf "%.2f MB", $2}')
SPACE_ROOT_USED=$(df -m / | awk 'NR==2{printf "%.2f MB", $3}')
SPACE_ROOT_FREE=$(df -m / | awk 'NR==2{printf "%.2f MB", $4}')
