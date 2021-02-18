## *
## String to upper case.
##
## Params:
##   *: {String} String to convert.
##
## Out: {String} Result string.

local text="$@"

[ ! -z "${text}" ] && tr '[a-z]' '[A-Z]' <<<"${text}"
