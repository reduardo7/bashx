##
## Get backtrace.
##
## Out: {String} Backtrace.

local i=0

while caller $i ; do ((i++)) ; done

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
