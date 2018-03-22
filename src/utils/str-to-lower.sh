## *
## String to lower case.
##
## *:   {String} String to convert.
## Out: {String} Result string.

tr '[A-Z]' '[a-z]' <<<"$*"
