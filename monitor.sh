
#!/bin/bash

# Linux System Health Monitoring Script

# Set the log and report locations
LOG_DIR="/var/log"
REPORT="health_report.txt"

# Start a new report
echo "===== SYSTEM HEALTH REPORT =====" > "$REPORT"
echo "Date: $(date)" >> "$REPORT"

# 1. Check the hostname
echo "" >> "$REPORT"
echo "===== HOSTNAME =====" >> "$REPORT"
hostname >> "$REPORT"

# 2. Check disk usage
echo "" >> "$REPORT"
echo "===== DISK USAGE =====" >> "$REPORT"

if df -h / >> "$REPORT" 2>&1; then
    echo "Disk check completed."
else
    echo "WARNING: Disk check failed." >> "$REPORT"
fi

# 3. List running processes
echo "" >> "$REPORT"
echo "===== RUNNING PROCESSES =====" >> "$REPORT"

if ps -eo pid,comm,%cpu,%mem >> "$REPORT" 2>&1; then
    echo "Process check completed."
else
    echo "WARNING: Process check failed." >> "$REPORT"
fi

# 4. Check whether the log directory exists
echo "" >> "$REPORT"
echo "===== LOG ANALYSIS =====" >> "$REPORT"

if [ -d "$LOG_DIR" ]; then

    # Find recent .log files and search them for errors
    FOUND_LOG=0

    for FILE in "$LOG_DIR"/*.log; do

        # Skip the loop if no matching files exist
        if [ ! -f "$FILE" ]; then
            continue
        fi

        FOUND_LOG=1

        echo "Checking: $FILE" >> "$REPORT"

        if grep -in "error" "$FILE" >> "$REPORT" 2>&1; then
            echo "Error entries found in $FILE"
        else
            echo "No matching errors found in $FILE" >> "$REPORT"
        fi

    done

    # Explain when no .log files were found
    if [ "$FOUND_LOG" -eq 0 ]; then
        echo "No .log files found in $LOG_DIR" >> "$REPORT"
    fi

else
    echo "WARNING: Log directory does not exist." >> "$REPORT"
fi

# 5. Check recent system journal errors
echo "" >> "$REPORT"
echo "===== RECENT SYSTEM ERRORS =====" >> "$REPORT"

if command -v journalctl >/dev/null 2>&1; then
    if journalctl -p err -n 10 --no-pager >> "$REPORT" 2>&1; then
        echo "Journal check completed."
    else
        echo "WARNING: Could not read the system journal." >> "$REPORT"
    fi
else
    echo "WARNING: journalctl is not installed." >> "$REPORT"
fi

# Finish the report
echo "" >> "$REPORT"
echo "===== MONITORING COMPLETE =====" >> "$REPORT"

echo "Monitoring finished. Report saved to $REPORT"
