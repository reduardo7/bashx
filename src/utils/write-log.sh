## *
## Write to LOG to File.
## Log file path at ${BX_LOG_FILE_PATH} variable.
##
## Params:
##   *: Text to log

@console-log "$*" >> "${BX_LOG_FILE_PATH}" 2>&1
