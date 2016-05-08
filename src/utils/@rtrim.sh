# Right @trim text.
#
# 1: {String} String where @trim.
# 2: {String} (Default: " ") String to @trim.
# Out: {String} Trimed text.
local chr=" "
if [ $# -gt 1 ]; then
  chr="$2"
fi
echo "$1" | sed "s/${chr}$//g"
