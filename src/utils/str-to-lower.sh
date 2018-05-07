## *
## String to lower case.
##
## Params:
##   *: {String} String to convert.
## Out: {String} Result string.

tr '[A-Z]' '[a-z]' <<<"$*"
