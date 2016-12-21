# Show error message and exit.
#
# 1: {String} Error message.
# 2: {Integer} (Default: 1) Exit code.

local msg="$1"
local code=$2

[ -z "${code}" ] && code=1

@alert "@@@ Error! @@@"

if [ ! -z "${msg}" ]; then
  @warn
  @alert "${msg}"
  @warn
fi

@warn "Backtrace:\n$(@backtrace)"

@end ${code}
