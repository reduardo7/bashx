## file [remove_extension]
## Get file name.
##
## Params:
##   file:             {String} File path.
##   remove_extension: {Boolean} Remove file extension from file name.
##                     Optional. Default: false.
##
## Out: {String} File name.

local file="$1"
local remove_extension=${2:-false}

if [ ! -z "${file}" ]; then
  # Remove path
  local _fname="$(basename "${file}")"

  # Remove extension
  ${remove_extension} && _fname="${_fname%.*}"

  # Result
  echo "${_fname}"
fi
