## functions_path [prefix]
## Generate *.sh functions from path.
##
## Params:
##   functions_path: {String} Path to scripts.
##   prefix:         {String} Prefix.
##                   Optional. Default: empty.

local functions_path="$1"
local prefix="$2"
local p='()'
local file_path

[ ! -z "${functions_path}" ] || @throw-invalid-param functions_path
[ -d "${functions_path}" ] || @throw-invalid-param functions_path 'Is not a valid path'

for file_path in ${functions_path}/*.sh ; do
  if [ -f "$file_path" ]; then
    # Create base util function
    eval "${prefix}$(@file-name "$file_path" true)$p { . "$file_path"; }"
  fi
done
