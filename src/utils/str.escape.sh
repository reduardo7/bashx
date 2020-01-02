## *
## Escape string for Bash.
##
## Params:
##   *: {String} String to escape for Bash.
##
## Out: {String} Escaped string.

local str="$@"

if [ ! -z "${str}" ]; then
  printf '%q' "${str}"
fi
