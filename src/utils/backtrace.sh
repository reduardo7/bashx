##
## Print backtrace
##
## Out: {String} Backtrace.

local i=0; while caller $i ;do ((i++)) ;done
