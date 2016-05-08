# Get file name.
#
# 1: {String} File path.
# 2: {Boolean} (Default: $FALSE) Remove file extension from file name?
# Out: {String} File name.

# Remove path
local _fname="`basename "${1}"`"
if [ "$2" == "$TRUE" ]; then
  # Remove extension
  _fname="`@str_replace "${_fname}" "\..*$" ""`"
fi
echo ${_fname}
