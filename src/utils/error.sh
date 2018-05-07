## msg [print_backtrace [code]]
## Show error message and exit.
##
## Params:
##   msg:             {String} Error message.
##   print_backtrace: {Boolean} (Default: false) Show Backtrace?
##   code:            {Integer} (Default: 1) Exit code.

local msg="$1"
local print_backtrace=${2:-false}
local code=${3:-1}

@alert "@@@ Error! @@@"

if [ ! -z "${msg}" ]; then
  @warn
  @alert "${msg}"
  @warn
fi

$print_backtrace && @warn "Backtrace:\n$(@backtrace)"

@end ${code}
