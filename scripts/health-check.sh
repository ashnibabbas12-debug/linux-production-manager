
#!/bin/bash

# ==========================================
# LINUX PRODUCTION MANAGER
# SYSTEM HEALTH MONITORING
# ==========================================

set -u

PROJECT_DIR="$HOME/linux-production-manager"
REPORT_DIR="$PROJECT_DIR/reports"
REPORT_FILE="$REPORT_DIR/system-report.txt"

# Create report directory if missing
mkdir -p "$REPORT_DIR"

# Report header
{
    echo "================================================"
    echo "         LINUX PRODUCTION MANAGER"
    echo "             SYSTEM HEALTH REPORT"
    echo "================================================"
    echo
    echo "Generated On : $(date)"
    echo "Hostname     : $(hostname)"
    echo "Operating OS : $(. /etc/os-release && echo "$PRETTY_NAME")"
    echo "Kernel       : $(uname -r)"
    echo "Architecture : $(uname -m)"
    echo

    echo "--------------- SYSTEM UPTIME ----------------"
    uptime
    echo

    echo "--------------- CPU INFORMATION --------------"
    echo "CPU Cores: $(nproc)"
    echo "CPU Model:"
    grep -m 1 "model name" /proc/cpuinfo | cut -d ':' -f 2
    echo "Load Average:"
    cat /proc/loadavg
    echo

    echo "--------------- MEMORY USAGE -----------------"
    free -h
    echo

    echo "--------------- DISK USAGE -------------------"
    df -h
    echo

    echo "--------------- TOP PROCESSES ----------------"
    ps aux --sort=-%mem | head -n 6
    echo

    echo "--------------- NETWORK INFORMATION ----------"
    hostname -I
    echo
    ip -brief address
    echo

    echo "--------------- HEALTH SUMMARY ---------------"

    MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')
    DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

    echo "Memory Usage : ${MEMORY_USAGE}%"
    echo "Root Disk    : ${DISK_USAGE}%"

    if [ "$MEMORY_USAGE" -lt 80 ] && [ "$DISK_USAGE" -lt 85 ]; then
        echo "Overall Status: HEALTHY"
    else
        echo "Overall Status: WARNING"
    fi

    echo
    echo "================================================"
    echo "             END OF REPORT"
    echo "================================================"

} > "$REPORT_FILE"

echo "System health report generated successfully!"
echo "Report location: $REPORT_FILE"
