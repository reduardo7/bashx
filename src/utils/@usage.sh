# Print basic usage.
#
# 1: {String} File to render usage.
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
  @error "@usage: Invalid file '${src}'" true 200
fi

# Get comments from file
egrep '^##' "${src}" | egrep -v '^###' | while read line
  do
    if ${first_line}; then
      first_line=false
      @print "  $(@style color:red)${src_name}$(@style color:green) ${cmd}${sd} $(@str-replace "${line}" '^##\s*' '')"
    else
      @print "$(@str-replace "${line}" '^##\s' "${sd}${lp}")"
    fi
  done

@print
