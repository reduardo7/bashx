## *
## Print command and their result.
##
## Params:
##   *: {String} Command to print and execute.
##
## Out: {String} Command executed and result.
## Return: Executed command exit code.

local cmd="$@"

@log
@log.line

@log "\$ ${cmd}"
eval "${cmd}"
local r=$?

@log
@log "\$ ${cmd} > Exit code: ${r}"
@log.line
@log

return ${r}

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
