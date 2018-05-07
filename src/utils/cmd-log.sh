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
@print-line
eval "set -x ; ${cmd}"
local r=$?
set +x
@print "Exit code: ${r}"
@print-line
echo >&3
return ${r}
