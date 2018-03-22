# Check if function exists.
#
# 1: {String} Function name.
# Return: 0 if function exists, 1 if file not exists.

local func_name="$1"

if declare -f "${func_name}" >/dev/null 2>&1
  then
    return 0
  else
    return 1
  fi
