## *
## Write to LOG to File.
## Log file path at LOG_FILE_PATH variable.
##
## *: Text to log

@console-log "$@" >> "$LOG_FILE_PATH" 2>&1
