## file [remove_extension]
## Get file name.
##
## Params:
##   file:             {String} File path.
##   remove_extension: {Boolean} (Default: false) Remove file extension from file name?
## Out: {String} File name.

local path="$1"
local remove_ext=$2

[ -z "${remove_ext}" ] && remove_ext=false

# Remove path
local _fname="$(basename "${1}")"

# Remove extension
${remove_ext} && _fname="${_fname%.*}"

# Result
echo "${_fname}"
