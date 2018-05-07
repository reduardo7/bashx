## *
## Print command and their result.
## Use it instead of "set -x".
##
## Params:
##   *: {String} Command to print and execute.
## Out: {String} Command executed and result.
## Return: Executed command exit code.

local cmd="$@"

@print
@print-line

@print "\$ ${cmd}"
eval "${cmd}"
local r=$?

@print
@print "\$ ${cmd} > Exit code: ${r}"
@print-line
@print

return ${r}
