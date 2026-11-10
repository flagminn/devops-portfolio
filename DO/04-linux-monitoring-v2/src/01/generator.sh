#!/bin/bash
generator() {
  name_files=""
  name_folders=""
  local logfile="log_$(date +%d.%m.%y).log"
  
  for ((f=0; f<folders; f++)); do #цикл по созданию папок
    check_space || exit 1
    for ((k=0; k<(4 - ${#chars_folders} + f); k++)); do #генератор имен папок
      name_folders="${chars_folders:0:1}${name_folders}"
    done
    name_folders="${name_folders}${chars_folders}_$(date +%d%m%y)"
    while [ -d ${path}/${name_folders} ]; do
        name_folders="${chars_folders:0:1}${name_folders}"
    done
    mkdir ${path}/${name_folders}
    echo "Создана папка" $path/${name_folders} $(date +%d.%m.%y)  >> "$logfile"
    
    for ((i=0; i<files; i++)); do #цикл внутри папки, создание файлов
      check_space || exit 1
      for ((j=0; j<(4 - ${#chars_files}+i); j++)); do #подбор имени файлов
        name_files="${chars_files:0:1}${name_files}"
      done
      while [ -f ${path}/${name_folders}/${name_files} ]; do
        name_files="${chars_files:0:1}${name_files}"
      done
      name_files="${name_files}${chars_files}_$(date +%d%m%y).${ext_files}"
      fallocate -l "${size}K" "$path/${name_folders}/${name_files}" #создание афайла с выделением памяти
      echo "Создан файл" $path/${name_folders}/${name_files} $(date +%d.%m.%y) ${size}K   >> "$logfile"
      name_files=""
    done
    name_folders=""
  done
  echo "Создание выполнено"
}
