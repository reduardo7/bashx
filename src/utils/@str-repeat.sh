# Repeat string.
#
# 1: {Integer} Number of repetitions.
# 2: {String} String to repeat.
# Out: {String} Repeated string.

let repeats_count=$1
local str="$2"

while [[ ${repeats_count} -gt 1 ]]; do
  str="${str}$2"
  let repeats_count=${repeats_count}-1
done

echo $str
