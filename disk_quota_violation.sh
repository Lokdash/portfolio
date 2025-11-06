#!/bin/bash

VIOLFOUND=0 #установка переменной для подсчета нарушений
MAXDISKUSAGE=20000 #установка переменной для лимита в Мб

#проверка всех системных пользователей с UID выше 100
for name in $(cut -d: -f1,3 /etc/passwd | awk -F: '$2 > 99 {print $1}')
do
    /bin/echo -n "User $name exceeds disk quota. Disk usage is: "
    find /home -xdev -user $name -type f -ls | \
        awk '{sum += $7} END { print sum / (1024*1024) "Mbytes"}'

done | awk "\$9 > $MAXDISKUSAGE {print \$0; found=1} END {exit !found}" && VIOLFOUND=1

#вывод в том случае, если квота соблюдена
if [ $VIOLFOUND -eq 0 ]; then
        echo "No quota violations found"
fi
exit 0
