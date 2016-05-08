# Show error message and exit.
#
# 1: {String} Error message.
# 2: {Integer} (Default: 1) Exit code.

if [ ! -z "$1" ]; then
  @alert "Error! $1"
else
  @e
fi

if [ $# -gt 1 ]; then
  @end $2
else
  @end 1
fi
