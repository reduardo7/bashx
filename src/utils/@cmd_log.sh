# Print command and their result.
#
# 1: {String} Command to print and execute.
# Out: {String} Command executed and result.
# Return: Executed command exit code.

echo
@str_repeat 80 '-'
echo "$ $1"
"$1"
local r=$?
@str_repeat 80 '-'
return $r
