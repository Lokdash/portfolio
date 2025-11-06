#!/bin/bash

VIOLFOUND=0
MAXDISKUSAGE=20000 #в Мб

for name in $(cut -d: -f1,3 /etc/passwd | awk -F: '$2 > 99 {print $1}')
do
    /bin/echo -n "User $name exceeds disk quota. Disk usage is: "
    find /home -xdev -user $name -type f -ls | \
        awk '{sum += $7} END { print sum / (1024*1024) "Mbytes"}'

done | awk "\$9 > $MAXDISKUSAGE {print \$0; found=1} END {exit !found}" && VIOLFOUND=1

if [ $VIOLFOUND -eq 0 ]; then
        echo "No quota violations found"
fi
exit 0
