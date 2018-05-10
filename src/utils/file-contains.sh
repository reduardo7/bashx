## text file
## Check if file contains text.
##
## Params:
##   text: {String} Text to search.
##   file: {String} Check file path.
##
## Return: 0 if file contains the text, 1 if not contains the text.

local text="$1"
local file="$2"

if [ ! -z "${file}" ] && [ -f "${file}" ] && [ ! -z "${text}" ]; then
  if grep -qrils "$(@str-escape "${text}")" "$(@str-escape "${file}")" ; then
    # Contains
    return 0
  fi
fi

# Not contains
return 1
