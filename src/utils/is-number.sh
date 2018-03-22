## var
## Check if is a number.
##
## var:    Variable to check if is a number.
## Return: 0 if variable is a number, 1 if variable is not a number.

local v="$1"

if [[ "${v}" =~ ^[0-9]+$ ]]; then
  return 0
else
  return 1
fi
