#!/bin/bash

get_info() {
  local target_dir=$1

  echo "Total number of folders (including all nested ones) = $(find "$target_dir" -type d | wc -l)"

  echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
  du -h "$target_dir" 2>/dev/null | sort -hr | head -n 6 | tail -n 5 | awk '{printf "%d - %s, %s\n", NR, $2, $1}'

  echo "Total number of files = $(find "$target_dir" -type f | wc -l)"

  echo "Number of:"
  echo "Configuration files (with the .conf extension) = $(find "$target_dir" -type f -name "*.conf" | wc -l)"
  echo "Text files = $(find "$target_dir" -type f -name "*.txt" | wc -l)"
  echo "Executable files = $(find "$target_dir" -type f -executable | wc -l)"
  echo "Log files (with the extension .log) = $(find "$target_dir" -type f -name "*.log" | wc -l)"
  echo "Archive files = $(find "$target_dir" -type f \( -name "*.tar" -o -name "*.zip" -o -name "*.gz" -o -name "*.rar" \) | wc -l)"
  echo "Symbolic links = $(find "$target_dir" -type l | wc -l)"

  echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
  find "$target_dir" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{
    split($2, a, ".");
    ext = a[length(a)];
    if (length(ext) == 0 || ext ~ /\//) ext = "no extension";
    printf "%d - %s, %s, %s\n", NR, $2, $1, ext
  }'

  echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
  find "$target_dir" -type f -executable -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{printf "%d - %s, %s, ", NR, $2, $1; system("md5sum " $2 " | cut -d\" \" -f1")}'
}
