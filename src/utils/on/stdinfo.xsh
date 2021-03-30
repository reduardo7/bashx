## *
## Add action to execute on stdinfo callback.
## You can access current line data from ${OUT_LINE} variable.
##
## Params:
##   *: Command to execute on each stdinfo line.
##
## Example:
##   _onStdInfo() {
##     local line="$1"
##     echo "++ ${line}"
##   }
##
##   @on.stdinfo '_onStdInfo "${OUT_LINE}"'

# Not implemented
exit 1

local cmd="$@"

if [[ ! -z "${cmd}" ]]; then
  [ -z "${BX_ON_STDINFO}" ] || BX_ON_STDINFO="${BX_ON_STDINFO};"
  BX_ON_STDINFO="${BX_ON_STDINFO}( ${cmd} )"
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
