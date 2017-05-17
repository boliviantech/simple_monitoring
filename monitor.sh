#! /bin/bash
IP=$(hostname -I)
echo "Hostname :" $HOSTNAME
echo "IP Address :" $IP
printf "MEMORY_USAGE\t\tDISK_USAGE\t\tCPU_LOAD\n"
end=$((SECONDS+43200))
while [ $SECONDS -lt $end ]; do
MEMORY=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
DISK=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}')
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
echo -e "$MEMORY\t$DISK\t\t$CPU"
sleep $1
done
