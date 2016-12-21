# Show error message and exit.
#
# 1: {String} Error message.
# 2: {Integer} (Default: 1) Exit code.

local msg="$1"
local code=$2

[ -z "${code}" ] && code=1

if [ ! -z "${msg}" ]; then
  @alert "Error! ${msg}"
else
  @print 3>&2
fi

@end ${code}
