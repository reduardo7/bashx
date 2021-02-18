## @
## Add action to execute @on.exit callback.
## You can access current exit code from ${EXIT_CODE} variable.
##
## Params:
##   @: Command to execute on APP exit.
##
## Example:
##   _onExit() {
##     local code=${1}
##     # ...
##   }
##
##   @on.exit '_onExit "${EXIT_CODE}"'

local cmd="$@"

if [ ! -z "${cmd}" ]; then
  [ -z "${BX_ON_EXIT}" ] || BX_ON_EXIT="${BX_ON_EXIT};"
  BX_ON_EXIT="${BX_ON_EXIT}( ${cmd} )"
fi
