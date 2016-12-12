# Explode string.
#
# 1: {String} Separator.
# 2: {String} String to explode.
# Output: Result
# Usage:
#    arr=($(@str-explode ";" "bla@some.com bbb;john@home.com jjj"))
#    for i in ${arr[@]} ; do
#        echo $i
#    done

local explode_char="$1"
local src_str="$2"
local prev="$IFS"

IFS="${explode_char}"
echo $(echo "${src_str}")
IFS="${prev}"
