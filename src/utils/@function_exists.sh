# Check if function exists.
#
# 1: {String} Function name.
# Return: $TRUE if function exists, $FALSE if file not exists.
declare -f "$1" >/dev/null
if [ $? -eq 0 ]; then
  return $TRUE
else
  return $FALSE
fi
