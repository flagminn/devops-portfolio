#!/bin/bash


logfile_gen(){
    dates=( "2026-03-24" "2026-03-25" "2026-03-26" "2026-03-27" "2026-03-28" )
    
    for (( l=0; l < 5; l++ )); do
        string_count=$( shuf -i 100-1000 -n 1)
        mapfile -t sorted_sec < <( shuf -i 1-86400 -n $string_count | sort -n )
        logfile="log_$((l + 1))_$(date -d "${dates[$l]}" "+%Y-%m-%d").log"
        for (( s=0; s < string_count; s++ )); do
            time=$(date -d "${dates[$l]} + ${sorted_sec[$s]} seconds" "+%d/%b/%Y:%H:%M:%S %z")
            size=$((RANDOM % 255))
            ip_gen
            code_gen
            url_gen
            agent_gen
            metod_gen
            echo "$ip - - [${time}] \"$metod $url HTTP/1.1\" $code \"-\" \"${agent}\"" >> $logfile
        done
    done
}