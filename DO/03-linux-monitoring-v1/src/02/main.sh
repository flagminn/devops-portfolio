#!/bin/bash


. "$(dirname "$0")/info.sh"
. "$(dirname "$0")/output.sh"

show_data

echo

read -p "Записать данные в файл? (Y/N): " answer


if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
    FILENAME=$(date +"%d_%m_%y_%H_%M_%S.status")
    show_data > "$FILENAME"
    echo "Данные успешно сохранены в файл: $FILENAME"
else
    echo "Запись отменена."
fi
