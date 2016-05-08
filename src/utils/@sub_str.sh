# Sub string.
# 1: {String} String to cut.
# 2: {Integer} Limit.
# 3: {Integer} (Optional) Offset.
# Out: {String} Result string
if [ $# -eq 2 ]; then
  echo ${1:0:$2}
else
  echo ${1:$3:$2}
fi
