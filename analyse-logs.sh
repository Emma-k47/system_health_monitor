#!/bin/bash
# Run this script with Bash, which provides the array syntax used below.

# Directory that contains the log files to inspect.
LOG_DIR="/Users/Emmanuel/logs"
# Text markers that this script treats as error-level events.
ERROR_PATTERNS=("ERROR" "FATAL" "CRITICAL")

# Print a short heading so the output is identifiable when run in a terminal.
echo "analysing log files"
# Separate the heading from the results with a visual rule.
echo "======================="

# Announce that the following list contains log files modified within the last day.
echo -e "\nList of log files updated in the last 24 hours"
# Find .log files under LOG_DIR modified less than 24 hours ago.
# Command substitution captures the matching paths as a string.
LOG_FILES=$(find $LOG_DIR -name '*.log' -mtime -1)
# Display the discovered paths before searching them.
echo "$LOG_FILES"

# Iterate over the discovered paths; unquoted expansion splits this list on whitespace.
for LOG_FILE in $LOG_FILES; do
    echo -e "\n"
    echo "================================"
    echo "==================$LOG_FILE=================="
    echo "================================"
    
    # Check each log file once for every marker configured in ERROR_PATTERNS.
    for ERROR_PATTERN in "${ERROR_PATTERNS[@]}"; do
        # Identify the marker and file currently being searched.
        echo -e "\nSearching for $ERROR_PATTERN logs in $LOG_FILE"
        # Print every line in this file containing the current marker.
        grep "$ERROR_PATTERN" "$LOG_FILE"

        # Label the count that the next command will print.
        echo -e "\nNumber of $ERROR_PATTERN logs found in $LOG_FILE"
        # Count matching lines; grep -c prints zero when there are no matches.
        grep -c "$ERROR_PATTERN" "$LOG_FILE"
    # Finish processing all severity markers for the current file.
    done
# Move on after all markers have been checked in the current file.
done

# The examples below are disabled; they show earlier searches for individual patterns
# and named log files. The active loops above handle all configured patterns and files.
# echo -e  "\nsearching ${ERROR_PATTERNS[0]} logs in the $APP_LOG_FILE"
# grep "${ERROR_PATTERNS[0]}" "$LOG_DIR/$APP_LOG_FILE"

# echo -e "\nNumber of ${ERROR_PATTERNS[0]} logs found in $APP_LOG_FILE"
# grep -c "${ERROR_PATTERNS[0]}" "$LOG_DIR/$APP_LOG_FILE"

# echo -e "\nNumber of ${ERROR_PATTERNS[1]} logs found in $APP_LOG_FILE"
# grep -c "${ERROR_PATTERNS[1]}" "$LOG_DIR/$APP_LOG_FILE"

# echo -e "\nNumber of ${ERROR_PATTERNS[1]} logs found in $SYS_LOG_FILE"
# grep -c "${ERROR_PATTERNS[1]}" "$LOG_DIR/$SYS_LOG_FILE"

# echo -e "\nNumber of ${ERROR_PATTERNS[2]} logs found in $SYS_LOG_FILE"
# grep -c "${ERROR_PATTERNS[2]}" "$LOG_DIR/$SYS_LOG_FILE"

# echo -e "\n${ERROR_PATTERNS[2]} logs in $SYS_LOG_FILE"
# grep "${ERROR_PATTERNS[2]}" "$LOG_DIR/$SYS_LOG_FILE"