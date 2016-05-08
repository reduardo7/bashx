# Repeat string.
#
# 1: {Integer} Number of repetitions.
# 2: {String} String to repeat.
# Out: {String} Repeated string.
let fillsize=$1
local fill=$2
while [ ${fillsize} -gt 1 ] ; do
  fill="${fill}$2"
  let fillsize=${fillsize}-1
done
echo $fill
