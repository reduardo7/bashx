# Show error message and exit.
#
# 1: {String} Error message.
# 2: {Boolean} (Default: true) Show Backtrace?
# 2: {Integer} (Default: 1) Exit code.

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
