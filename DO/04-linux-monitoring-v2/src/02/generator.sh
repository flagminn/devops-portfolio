#!/bin/bash
generator() {
  name_files=""
  name_folders=""
  time_start_sec=$(date +%s)
  time_start_h=$(date +"%d.%m.%Y %H:%M:%S")
  local logfile="log_$(date +%d.%m.%y).log"
  
  
    
  for ((p=0; p<100; p++)); do #цикл по созданию папок
    path="${folders_list[p]}"
    for ((k=0; k<(5 - ${#chars_folders} + p); k++)); do #генератор имен папок
      name_folders="${chars_folders:0:1}${name_folders}"
    done
    name_folders="${name_folders}${chars_folders}_$(date +%d%m%y)"
    while [ -d ${path}/${name_folders} ]; do
        name_folders="${chars_folders:0:1}${name_folders}"
    done
    mkdir ${path}/${name_folders}
    echo "Создана папка" $path/${name_folders} $(date +%d.%m.%y)  >> "$logfile"
    
    for ((i=0; i<random_files[p]-1; i++)); do #цикл внутри папки, создание файлов
      check_space || break
      for ((j=0; j<(5 - ${#chars_files}+i); j++)); do #подбор имени файлов
        name_files="${chars_files:0:1}${name_files}"
      done
      while [ -f ${path}/${name_folders}/${name_files} ]; do
        name_files="${chars_files:0:1}${name_files}"
      done
      name_files="${name_files}${chars_files}_$(date +%d%m%y).${ext_files}"
      fallocate -l "${size}M" "$path/${name_folders}/${name_files}" #создание афайла с выделением памяти
      echo "Создан файл" $path/${name_folders}/${name_files} $(date +%d.%m.%y) ${size}M   >> "$logfile"
      name_files=""
    done
    name_folders=""
  done
  
  time_end_sec=$(date +%s)
  time_end_h=$(date +"%d.%m.%Y %H:%M:%S")
  time_diff=$(( time_end_sec - time_start_sec))
  echo "Создание папок выполнено"
  echo "Общее время выполнения скрипта составило $time_diff сек."
  echo "Время начала работы скрипта: ${time_start_h}." >> $logfile
  echo "Время окончания работы скрипта: ${time_end_h}." >> $logfile
  echo "Общее время выполнения работы скрипта составило $time_diff сек." >> $logfile


}
