## [len [str [prefix [suffix]]]]
## Print line with {str}.
##
## Params:
##   len:    {Integer} Line length ({str} repeat count).
##           Optional. Default: ${BX_APP_WIDTH}.
##   str:    {String} String to repeat in line.
##           Optional. Default: '='.
##   prefix: {String} Line prefix.
##           Optional. Default: ''.
##   suffix:  {String} Line suffix.
##           Optional. Default: ''.

local len=${1:-${BX_APP_WIDTH}}
local str="${2:-=}"
local prefix="${3}"
local suffix="${4}"

@log "${prefix}$(@str.repeat ${len} "${str}")${suffix}"
