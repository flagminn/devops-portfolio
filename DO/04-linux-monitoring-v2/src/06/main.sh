#!/bin/bash

sudo apt update
sudo apt install goaccess
goaccess "${logfile[@]}" --log-format=COMBINED -o report.html
echo "Веб-отчет сформирован: report.html"
xdg-open report.html
