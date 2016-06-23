# Print command and their result.
#
# *: {String} Command to print and execute.
# Out: {String} Command executed and result.
# Return: Executed command exit code.

echo 1>&2
@str-repeat 80 '-' 1>&2
echo "$ $@" 1>&2
$@
local r=$?
@str-repeat 80 '-' 1>&2
return $r
