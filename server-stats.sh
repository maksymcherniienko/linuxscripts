#rough cpu usage ("%.2f" makes output 2 digits after comma)
echo "--------------------------------------------------------------------------------------"
echo -e "Your OS: $(awk -F'[="]' '/PRETTY_NAME/ {print $3}' /etc/os-release) \n"

echo "Cpu usage: $(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{printf "%.2f", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')%"

#Memory usage
echo "Memory usage: $(awk '/MemAvailable/ {free=$2} /MemTotal/ {total=$2} END {printf "%.2f", 100-(free / total)*100}' /proc/meminfo)%"

#Mem Available vs Mem Total in gb
echo "Available memory: $(awk '/MemAvailable/ {printf "%.2f", ($2/1048576)}' /proc/meminfo) G"
echo "Total Memory: $(awk '/MemTotal/ {printf "%.2f", ($2/1048576)}' /proc/meminfo) G"

#Total disk space i guess...
echo "Total disk space: $(df --exclude-type=tmpfs --total -h | awk '/total/ {printf $2}')"

#Used disk space
echo -e "Used disk space: $(df --exclude-type=tmpfs --total -h | awk '/total/ {printf $3}' ) \n You used $(df --exclude-type=tmpfs --total -h | awk '/total/ {printf "%.0f", $5}')% of disk space"

#top 5 by cpu
echo -e "Top 5 CPU eaters: \n $(ps -eo user,pcpu,pid,ppid,tid,cmd,ni,pri,psr,rtprio --sort=-%cpu | head -6)"

#top 5 by memory
echo -e "Top 5 Memory eaters: \n $(ps -eo user,pmem,pid,ppid,tid,cmd,ni,pri,psr,rtprio --sort=-%mem | head -6)"
echo "--------------------------------------------------------------------------------------"

