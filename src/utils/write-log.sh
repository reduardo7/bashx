## *
## Write to LOG to File.
## Log file path at LOG_FILE constant.
##
## *: Text to log

@console-log "$@" >> "$LOG_FILE" 2>&1
