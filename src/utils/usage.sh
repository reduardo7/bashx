## src [prefix]
## Print basic script usage.
##
## Params:
##   src:    {String} File to read usage.
##   prefix: {String} Usage prefix.
##           Optional. Default: ${SCRIPT_FILE_NAME}.
##
## Out: {String} Usage text.

local src="$1"
local prefix="${2:-$SCRIPT_FILE_NAME}"
local cmd="$(@file-name "${src}" true)"

if [[ "${cmd}" == _* ]]; then
  return 0
fi

local lp='    '
local lpl=${#lp}
local first_line=true
local sd="$(@style default)"
local info

if [ -z "${src}" ] || [ ! -f "${src}" ]; then
  @throw-invalid-state "Invalid file '${src}'"
fi

if [ ! -z "${prefix}" ]; then
  prefix="$(@style color:red)${prefix}"
fi

# Get comments from file
egrep '^##' "${src}" | egrep -v '^###' | while read line
  do
    if ${first_line}; then
      first_line=false
      @print "  ${prefix}$(@style color:green)${cmd}${sd} $(@str-replace "${line}" '^##\s*' '')"
    else
      @print "$(@str-replace "${line}" '^##\s' "${sd}${lp}")"
    fi
  done

@print
