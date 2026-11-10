#!/bin/bash

start_time=$(date +%s.%N)

if [ "$#" -ne 1 ]; then
    echo "Error: Directory path is required."
    exit 1
fi

target_dir=$1

if [[ "${target_dir: -1}" != "/" ]]; then
    echo "Error: The path must end with '/'."
    exit 1
fi

if [ ! -d "$target_dir" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

. "$(dirname "$0")/info.sh"

get_info "$target_dir"

end_time=$(date +%s.%N)
execution_time=$(echo "$end_time - $start_time" | bc)

printf "Script execution time (in seconds) = %.2f\n" "$execution_time"
