## @
## Add action to execute on stdout callback.
## You can access current line data from ${OUT_LINE} variable.
##
## Params:
##   @: Command to execute on each stdout line.
##
## Example:
##   _onStdOut() {
##     local line="$1"
##     echo "++ ${line}"
##   }
##
##   @on.stdout '_onStdOut "${OUT_LINE}"'

local cmd="$@"

if [ ! -z "${cmd}" ]; then
  [ -z "${BX_ON_STDOUT}" ] || BX_ON_STDOUT="${BX_ON_STDOUT};"
  BX_ON_STDOUT="${BX_ON_STDOUT}( ${cmd} )"
fi
