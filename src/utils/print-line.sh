## [len [str [prefix [suffix]]]]
## Print line.
##
## Params:
##   len:    {Integer} Line length ({str} repeat count).
##           Optional. Default: 80.
##   str:    {String} String to repeat in line.
##           Optional. Default: '='.
##   prefix: {String} Line prefix.
##           Optional. Default: ''.
##   suffix:  {String} Line suffix.
##           Optional. Default: ''.

local len=${1:-80}
local str="${2:-=}"
local prefix="${3}"
local suffix="${4}"

@print "${prefix}$(@str-repeat ${len} "${str}")${suffix}"
