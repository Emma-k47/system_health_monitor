# Linux System Health Monitor

## Project Purpose
A Bash script that collects basic Linux system health
information and searches selected log files for errors.

## Features
- Hostname collection
- Disk usage check
- Running process listing
- Log file error search
- Recent system journal entries
- Text report generation

## Requirements
- Ubuntu Linux
- Bash
- Standard Linux command-line utilities

## Usage
Run the script with:

    ./monitor.sh

## Output
The script generates health_report.txt.

## Limitations
- Only selected log files are searched.
- Some logs may require additional permissions.
- The script does not currently enforce health thresholds.
