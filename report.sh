#!/bin/bash

# define the output file
output_file="system_report.txt"

# capture the current date and time
current_date_time=$(date)

# capture the name of the current user
current_user=$(whoami)

# capture the internal IP address and hostname
internal_ip=$(hostname -I | awk '{print $1}')
hostname=$(hostname)

# capture the external IP address
external_ip=$(curl -s ifconfig.me)

# capture the name and version of Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    os_name=$NAME
    os_version=$VERSION
fi

# capture the system uptime
uptime_info=$(uptime -p)

# capture information about used and free space in / in GB
disk_usage=$(df -h / | awk 'NR==2 {print "Used: " $3 ", Free: " $4}')

# capture information about total and free RAM
ram_info=$(free -h | awk 'NR==2 {print "Total: " $2 ", Free: " $4}')

# captue information about cpu cores and frequency
cpu_cores=$(lscpu | awk '/^CPU\(s\):/ {print $2}')
cpu_frequency=$(lscpu | awk '/^CPU MHz:/ {print $3}')
cpu_info="Cores: $cpu_cores, Frequency: ${cpu_frequency} MHz"

# Generate the report
cat <<EOF > $output_file
System Report
===============================
Date and Time: $current_date_time
User: $current_user
Internal IP Address: $internal_ip
Hostname: $hostname
External IP Address: $external_ip
OS: $os_name $os_version
Uptime: $uptime_info
Disk Usage: $disk_usage
RAM Info: $ram_info
CPU Info: $cpu_info
===============================
EOF
