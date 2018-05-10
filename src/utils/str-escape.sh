## *
## Escape string for Bash.
##
## Params:
##   *: {String} String to escape for Bash.
##
## Out: {String} Escaped string.

if [ ! -z "$*" ]; then
  printf '%q' "$*"
fi
