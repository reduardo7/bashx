## *
## Add action to execute on.exit callback.
##
## Params:
##   *: Command to execute on APP exit.

local cmd="$@"

if [ ! -z "${cmd}" ]; then
  _BASHX_ON_EXIT="${_BASHX_ON_EXIT} ; ( ${cmd} )"
fi
