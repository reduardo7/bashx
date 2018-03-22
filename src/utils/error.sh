## msg [print_backtrace [code]]
## Show error message and exit.
##
## msg:             {String} Error message.
## print_backtrace: {Boolean} (Default: true) Show Backtrace?
## code:            {Integer} (Default: 1) Exit code.

local msg="$1"
local show_backtrace=$2
local code=$3

[ -z "${show_backtrace}" ] && show_backtrace=true
[ -z "${code}" ] && code=1

@alert "@@@ Error! @@@"

if [ ! -z "${msg}" ]; then
  @warn
  @alert "${msg}"
  @warn
fi

$show_backtrace && @warn "Backtrace:\n$(@backtrace)"

@end ${code}
