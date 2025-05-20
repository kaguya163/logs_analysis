#!/bin/bash

# Путь к лог-файлу
LOG_FILE="access.log"
REPORT_FILE="report.txt"

# Общее количество запросов
total_requests=$(wc -l < "$LOG_FILE")

# Количество уникальных IP-адресов (используем awk)
unique_ips=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

# Количество запросов по методам (используем awk)
method_counts=$(awk '{print $6}' "$LOG_FILE" | cut -d'"' -f2 | sort | uniq -c)

# Самый популярный URL (используем awk)
popular_url=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1)

# Сохраняем отчет
{
echo "Отчет о логе веб-сервера"
echo "========================="
echo
echo "Общее количество запросов:       $total_requests"
echo "Количество уникальных IP-адресов: $unique_ips"
echo
echo "Количество запросов по методам:"
echo "$method_counts"
echo
echo "Самый популярный URL: $popular_url"
} > "$REPORT_FILE"

echo "Отчет сохранен в файл $REPORT_FILE"
