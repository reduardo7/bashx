## [len [str [prefix [sufix]]]]
## Print line.
##
## Params:
##   len:    {Integer} Line length ({str} repeat count).
##           Optional. Default: 80
##   str:    {String} String to repeat in line.
##           Optional. Default: '='
##   prefix: {String} Line prefix.
##           Optional. Default: ''
##   sufix:  {String} Line sufix.
##           Optional. Default: ''

local len=${1:-80}
local str="${2:-=}"
local prefix="${3}"
local sufix="${4}"

@print "${prefix}$(@str-repeat ${len} "${str}")${sufix}"
