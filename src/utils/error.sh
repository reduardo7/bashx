## msg [print_backtrace [code]]
## Show error message and exit.
##
## Params:
##   msg:             {String} Error message.
##   print_backtrace: {Boolean} Show Backtrace?
##                    Optional. Default: false.
##   code:            {Integer} Exit code.
##                    Otional. Default: 1.

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
