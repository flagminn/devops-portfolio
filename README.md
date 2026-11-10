# DevOps & Systems Engineering Portfolio

Комплексное портфолио инфраструктурных проектов, системного администрирования, автоматизации CI/CD, контейнеризации и работы с базами данных.

---

## 📂 Структура репозитория

Портфолио разделено на три основных трека:

### 1. 🛠️ Системное администрирование и DevOps (`DO/`)
Проекты по настройке Linux, сетевым протоколам, мониторингу, логированию, контейнеризации и CI/CD конвейерам.
* **[01-linux-administration](DO/01-linux-administration/)** — Управление пользователями, файловыми системами, дисками и системными службами в Linux.
* **[02-linux-networks](DO/02-linux-networks/)** — Настройка сетевых интерфейсов, маршрутизации, межсетевых экранов (`iptables`, `nftables`) и анализ трафика.
* **[03-linux-monitoring-v1](DO/03-linux-monitoring-v1/)** — Разработка утилит на Bash для сбора системных метрик и анализа производительности ОС.
* **[04-linux-monitoring-v2](DO/04-linux-monitoring-v2/)** — Продвинутая система мониторинга сбора метрик производительности системы.
* **[05-simple-docker](DO/05-simple-docker/)** — Контейнеризация веб-приложений, написание эффективных `Dockerfile`, управление образами и томами.
* **[06-ci-cd](DO/06-ci-cd/)** — Автоматизация сборки, тестирования и деплоя с использованием GitLab CI/CD.
* **[07-docker-compose](DO/07-docker-compose/)** — Оркестрация многоконтейнерных приложений (микросервисная архитектура, сети, Volumes).
* **[08-monitoring-alerting](DO/08-monitoring-alerting/)** — Настройка систем мониторинга, сбора логов и алертинга (Prometheus, Grafana, Alertmanager).

### 2. 🗄️ Базы данных и SQL (`SQL/`)
Проекты, охватывающие реляционные базы данных, моделирование, оптимизацию запросов, индексирование и администрирование PostgreSQL.
* **[01-sql-basics](SQL/01-sql-basics/)** — Основы реляционных БД, базовые выборки, фильтрация и агрегация данных.
* **[02-sql-joins-sets](SQL/02-sql-joins-sets/)** — Объединение таблиц (`JOIN`), операции с множествами.
* **[03-sql-advanced-joins](SQL/03-sql-advanced-joins/)** — Сложные соединения, оконные функции и иерархические запросы.
* **[04-sql-dml-modifications](SQL/04-sql-dml-modifications/)** — Управление данными (`INSERT`, `UPDATE`, `DELETE`), транзакции и целостность.
* **[05-sql-snapshots-views](SQL/05-sql-snapshots-views/)** — Создание представлений (`VIEW`), материализованных представлений и снимков данных.
* **[06-sql-graph-tsp](SQL/06-sql-graph-tsp/)** — Решение задач на графах средствами SQL (поиск путей, оптимизация).
* **[07-sql-indexes](SQL/07-sql-indexes/)** — Создание и оптимизация индексов (`B-Tree`, `Hash`), анализ планов выполнения запросов (`EXPLAIN ANALYZE`).
* **[08-sql-features-integration](SQL/08-sql-features-integration/)** — Интеграция БД с внешними приложениями, расширенные возможности SQL.
* **[09-sql-olap](SQL/09-sql-olap/)** — Аналитические запросы, кубы данных (`CUBE`, `ROLLUP`, `GROUPING SETS`).
* **[10-sql-isolation-levels](SQL/10-sql-isolation-levels/)** — Уровни изоляции транзакций, параллельный доступ и борьба с аномалиями (`Dirty Read`, `Phantom Read`, `Deadlock`).
* **[11-sql-functions-procs](SQL/11-sql-functions-procs/)** — Написание хранимых процедур, пользовательских функций (`PL/pgSQL`) и триггеров.

### 3. 💻 Прикладная разработка и автоматизация (`APP/`)
Проекты по разработке утилит, алгоритмов и бэкенд-сервисов на Python.
* **[01-python-algorithms-basics](APP/01-python-algorithms-basics/)** — Базовые алгоритмы и структуры данных на Python.
* **[02-python-multiprocessing-simulation](APP/02-python-multiprocessing-simulation/)** — Симуляции и параллельная обработка данных (процессы, потоки, синхронизация).
* **[03-flask-tic-tac-toe-api](APP/03-flask-tic-tac-toe-api/)** — RESTful API сервис на Flask для игры в крестики-нолики.
* **[04-flask-multiplayer-postgresql](APP/04-flask-multiplayer-postgresql/)** — Полноценное веб-приложение на Flask с персистентностью в PostgreSQL и поддержкой многопользовательской игры.

---

## 🛠️ Технологический стек

* **ОС и Сети:** Linux (Ubuntu, CentOS, Debian), Bash, TCP/IP, DNS, Routing, `iptables`, `nftables`
* **Инфраструктура & CI/CD:** Docker, Docker Compose, GitLab CI/CD, Prometheus, Grafana, Alertmanager
* **Базы данных:** PostgreSQL (`PL/pgSQL`, индексация, транзакции, OLAP)
* **Языки программирования:** Python, SQL, Bash
