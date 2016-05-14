# Explode string into $RESULT as Array.
#
# 1: {String} Separator.
# 2: {String} String to explode.
# Result in $RESULT.
# Return: Array length.
# Use:
#    @str-explode ";" "bla@some.com bbb;john@home.com jjj"
#    for i in ${RESULT[@]} ; do
#        echo $i
#    done
local i="$IFS"
IFS="$1"
RESULT=( `echo "$2"` )
IFS="$i"
return ${#RESULT[@]}
