## var
## Check if is a number.
##
## Params:
##   var: Variable to check if is a number.
##
## Return: 0 if variable is a number, 1 if variable is not a number.

local var="$1"

if [[ "${var}" =~ ^[0-9]+$ ]]; then
  return 0
fi

return 1
