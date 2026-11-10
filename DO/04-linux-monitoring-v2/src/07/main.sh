#!/bin/bash

#установка node exporter
sudo apt update
sudo apt install prometheus-node-exporter
sudo systemctl enable --now prometheus-node-exporter

#установка Prometheus
sudo apt install prometheus
#sudo nano /etc/prometheus/prometheus.yml

# 1. Включаем и запускаем Grafana
sudo systemctl daemon-reload
sudo systemctl enable --now grafana-server

# 2. Включаем и запускаем Node Exporter (датчики)
sudo apt install -y prometheus-node-exporter
sudo systemctl enable --now prometheus-node-exporter

# 3. Включаем и запускаем Prometheus (архив)
sudo apt install -y prometheus
sudo systemctl enable --now prometheus

sudo systemctl status grafana-server
