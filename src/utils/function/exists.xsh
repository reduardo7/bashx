## func_name
## Check if function exists.
##
## Params:
##   func_name: {String} Function name.
##
## Return: 0 if function exists, 1 if file not exists.

local func_name="$1"

if [ ! -z "${func_name}" ]; then
  declare -f "${func_name}" >/dev/null 2>&1 && return 0
fi

return 1
