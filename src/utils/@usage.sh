# Print basic usage.
# Using "ACTIONS." at begin of function name to set as argument method.
# Put "#" before function to write extra help text.
# Special chars: \n, \t (4 spaces)
#
# 1: {String} (Default: Current executed file) File to render usage.
# Out: {String} Usage text.

local src="$1"
local lp='    '
local lpl=${#lp}
local src_name="$(@script-file-name)"
local cmd="$(@file-name "${src}" true)"
local first_line=true
local sd="$(@style default)"
local info

if [ -z "${src}" ] || [ ! -f "${src}" ]; then
  src="$(@script-full-path)"
fi

@style default >&2

# Get comments from file
egrep '^##' "${src}" | while read line
  do
    if ${first_line}; then
      first_line=false
      @e "  $(@style color:red)${src_name}$(@style color:green) ${cmd}${sd} $(@str-replace "${line}" '^##\s*' '')"
    else
      @e "$(@str-replace "${line}" '^##\s' "${sd}${lp}")"
    fi
  done

@e
