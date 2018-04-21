## text [to_remove]
## Remove starting and ending spaces from text.
##
## text:      {String} Text.
## to_remove: {String} (Optional. Default: ' ') String to remove
## Out: {String} Trimed text.

local a="$1"
local b=''
local s="${2:- }"

while [[ ${#a} -ne ${#b} ]]; do
  b="$a"
  a="${a#$s}" # LTRIM
  a="${a%$s}" # RTRIM
done

echo -n "$a"
