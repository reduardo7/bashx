## text file
## Check if file contains text.
##
## Params:
##   text: {String} Text to search.
##   file: {String} File where check.
##
## Return: 0 if file contains the text, 1 if not contains the text.

if grep -rils "$(@str-escape "$1")" "$(@str-escape "$2")" >/dev/null 2>&1 ; then
  # Contains
  return 0
else
  # Not contains
  return 1
fi
