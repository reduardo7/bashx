## file [prefix]
## Print basic usage.
##
## file: {String} File to render usage.
## prefix: {String} Prefix to render.
## Out: {String} Usage text.

local src="$1"
local prefix="$2"
local cmd="$(@file-name "${src}" true)"

if [[ "${cmd}" == _* ]]; then
  return 0 # Brak
fi

local lp='    '
local lpl=${#lp}
local first_line=true
local sd="$(@style default)"
local info

if [ -z "${src}" ] || [ ! -f "${src}" ]; then
  @error "Invalid file '${src}'" true 200
fi

if [ ! -z "${prefix}" ]; then
  prefix="${prefix} "
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
