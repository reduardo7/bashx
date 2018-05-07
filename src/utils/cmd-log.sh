## *
## Print command and their result.
## Use it instead of "set -x".
##
## Params:
##   *: {String} Command to print and execute.
## Out: {String} Command executed and result.
## Return: Executed command exit code.

local cmd="$@"

echo >&3
@print "$(@str-repeat 80 '-')"
eval "set -x ; ${cmd}"
local r=$?
set +x
echo
echo -e "$(@style reset)Exit code: ${r}" >&3
@print "$(@str-repeat 80 '-')"
echo >&3
return ${r}
