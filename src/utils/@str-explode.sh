# Explode string.
#
# 1: {String} Separator.
# 2: {String} String to explode.
# Output: Result
# Usage:
#    arr=(`@str-explode ";" "bla@some.com bbb;john@home.com jjj"`)
#    for i in ${arr[@]} ; do
#        echo $i
#    done
local i="$IFS"
IFS="$1"
echo `echo "$2"`
IFS="$i"
