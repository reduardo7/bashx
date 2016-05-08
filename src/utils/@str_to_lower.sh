# String to lower case.
#
# *: {String} String to convert.
# Out: {String} Result string.
echo "$@" | tr '[A-Z]' '[a-z]'
