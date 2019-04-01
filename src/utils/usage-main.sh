## src [prefix]
## Print basic main script usage.
##
## Params:
##   src:    {String} File to read usage.
##   prefix: {String} Usage prefix.
##           Optional. Default: ${BX_SCRIPT_FILE_NAME}.
##
## Out: {String} Usage text.

local src="$1"
local prefix="${2:-$BX_SCRIPT_FILE_NAME} "
local line
local cmd="$(@file-name "${src}" true)"

if [[ "${cmd}" == _* ]]; then
  return 0
fi

egrep "^\\s*${BASHX_ACTION_PREFIX}\.[^()]+\\(\\)\\s*\\{" "${src}" \
  | egrep -v "^\\s*${BASHX_ACTION_PREFIX}\._" \
  | while read line
  do
    # Script name & action
    line="  $(@style color:red)${prefix}$(@style color:green)$(@str-replace "${line}" "^\\s*${BASHX_ACTION_PREFIX/\@/\\@}\\." '')"
    # Parameters
    line="$(@str-replace "${line}" '\(\)\s*\{\s*#*\s*' "$(@style default) ")"
    # Doc Lines
    line="$(@str-replace "${line}" '\s*\\n\\t\s*' "\n      ")"
    line="$(@str-replace "${line}" '\s*\\n\s*' "\n    ")"
    # Tab > Space
    @print "$(@str-replace "${line}" '\s*\\t\s*' '  ')"
    # Space
    @print
  done
