## @
## Add action to execute on stderr callback.
## You can access current line data from ${OUT_LINE} variable.
##
## Params:
##   @: Command to execute on each stderr line.
##
## Example:
##   _onStdErr() {
##     local line="$1"
##     echo "++ ${line}"
##   }
##
##   @on.stderr '_onStdErr "${OUT_LINE}"'

# Not implemented
exit 1

local cmd="$@"

if [[ ! -z "${cmd}" ]]; then
  [ -z "${BX_ON_STDERR}" ] || BX_ON_STDERR="${BX_ON_STDERR};"
  BX_ON_STDERR="${BX_ON_STDERR}( ${cmd} )"
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
