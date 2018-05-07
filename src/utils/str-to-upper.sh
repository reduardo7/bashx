## *
## String to upper case.
##
## Params:
##   *: {String} String to convert.
## Out: {String} Result string.

tr '[a-z]' '[A-Z]' <<<"$*"
