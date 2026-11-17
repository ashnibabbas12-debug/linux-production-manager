
#!/bin/bash

# Linux Production Manager - Log Analyzer

set -u

PROJECT_DIR="$HOME/linux-production-manager"
LOG_FILE="$PROJECT_DIR/app/app.log"
REPORT_DIR="$PROJECT_DIR/reports"

ERROR_REPORT="$REPORT_DIR/error-report.txt"
SUMMARY_REPORT="$REPORT_DIR/log-summary.txt"

# Check source log
if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: Log file not found!"
    exit 1
fi

mkdir -p "$REPORT_DIR"

# Count log levels
TOTAL_LINES=$(wc -l < "$LOG_FILE")
ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE" || true)
WARNING_COUNT=$(grep -c "WARNING" "$LOG_FILE" || true)
INFO_COUNT=$(grep -c "INFO" "$LOG_FILE" || true)

# Generate error report
{
    echo "=========================================="
    echo "       LINUX PRODUCTION MANAGER"
    echo "              ERROR REPORT"
    echo "=========================================="
    echo "Generated: $(date)"
    echo
    echo "ERROR ENTRIES:"
    grep -n "ERROR" "$LOG_FILE" || echo "No errors found."
    echo
    echo "WARNING ENTRIES:"
    grep -n "WARNING" "$LOG_FILE" || echo "No warnings found."
    echo
    echo "Total Errors: $ERROR_COUNT"
    echo "Total Warnings: $WARNING_COUNT"
    echo "Total INFO: $INFO_COUNT"
    echo "Total Lines: $TOTAL_LINES"
} > "$ERROR_REPORT"

# Generate summary
{
    echo "========== LOG SUMMARY =========="
    echo "Total Lines : $TOTAL_LINES"
    echo "INFO        : $INFO_COUNT"
    echo "WARNING     : $WARNING_COUNT"
    echo "ERROR       : $ERROR_COUNT"
    echo "================================="
} > "$SUMMARY_REPORT"

echo "Log analysis completed successfully!"
echo "Errors   : $ERROR_COUNT"
echo "Warnings : $WARNING_COUNT"
echo "INFO     : $INFO_COUNT"
echo "Reports generated in: $REPORT_DIR"
