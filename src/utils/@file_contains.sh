# Check if file contains text.
#
# 1: {String} Text to search.
# 2: {String} File where check.
# Return: 0 if file contains the text, 1 if not contains the text.

if grep -rils `@str_escape "$1"` `@str_escape "$2"` &> $DEV_NULL ; then
  # Contains
  return 0
else
  # Not contains
  return 1
fi
