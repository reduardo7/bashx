## *
## Add action to execute on-exit callback.
##
## Params:
##   *: Command to execute on APP exit.

local cmd="$@"

if [ ! -z "${cmd}" ]; then
  _ON_EXIT="${_ON_EXIT} ; ( ${cmd} )"
fi
