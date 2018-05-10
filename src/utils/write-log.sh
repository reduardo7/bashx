## *
## Write to LOG to File.
## Log file path at LOG_FILE_PATH variable.
##
## Params:
##   *: Text to log

@console-log "$*" >> "$LOG_FILE_PATH" 2>&1
