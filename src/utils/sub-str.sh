# Sub string.
# 1: {String} String to cut.
# 2: {Integer} Limit.
# 3: {Integer} (Optional) Offset.
# Out: {String} Result string

local src_str="$1"
local limit=$2
local offset=$3

if [ -z "${offset}" ] || [[ ${offset} -eq 0 ]]; then
  echo "${src_str:0:${limit}}"
else
  echo "${src_str:${offset}:${limit}}"
fi
