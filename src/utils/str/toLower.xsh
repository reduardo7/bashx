## *
## String to lower case.
##
## Params:
##   *: {String} String to convert.
##
## Out: {String} Result string.

local text="$@"

[ ! -z "${text}" ] && echo "${text}" | tr '[A-Z]' '[a-z]'
