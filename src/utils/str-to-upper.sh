# String to upper case.
#
# *: {String} String to convert.
# Out: {String} Result string.

tr '[a-z]' '[A-Z]' <<<"$*"
