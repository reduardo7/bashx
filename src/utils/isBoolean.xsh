## var
## Check if is boolean.
##
## Params:
##   var: Variable to check if is boolean. Valid values: "true" and "false".
##
## Return: 0 if variable is boolean, 1 if variable is not boolean.

local var="$1"

if [[ "${var}" == 'true' ]] || [[ "${var}" == 'false' ]]; then
  return 0
fi

return 1

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
