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

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
