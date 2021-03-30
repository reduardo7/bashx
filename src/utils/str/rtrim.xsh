## text [to_remove]
## Remove ending spaces from text.
##
## Params:
##   text:      {String} Text.
##   to_remove: {String} String to remove.
##              Optional. Default: " ".
##
## Out: {String} Trimed text.

local text="$1"
local to_remove="${2:- }"

if \
  [[ ! -z "${text}" ]] && \
  [[ ! -z "${to_remove}" ]]
then
  local old=''

  while [[ ${#text} -ne ${#old} ]]; do
    old="${text}"
    text="${text%$to_remove}" # RTRIM
  done
fi

echo -n "${text}"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
