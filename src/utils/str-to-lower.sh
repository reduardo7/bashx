## *
## String to lower case.
##
## Params:
##   *: {String} String to convert.
##
## Out: {String} Result string.

local text="$@"

[ ! -z "${text}" ] && tr '[A-Z]' '[a-z]' <<<"${text}"
