# String to upper case.
#
# *: {String} String to convert.
# Out: {String} Result string.

echo "$@" | tr '[a-z]' '[A-Z]'
