## text [to_remove]
## Remove starting spaces from text.
##
## Params:
##   text:      {String} Text.
##   to_remove: {String} (Optional. Default: ' ') String to remove
## Out: {String} Trimed text.

local a="$1"
local b=''
local s="${2:- }"

while [[ ${#a} -ne ${#b} ]]; do
  b="$a"
  a="${a#$s}" # LTRIM
done

echo -n "$a"
