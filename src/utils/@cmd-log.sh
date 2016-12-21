# Print command and their result.
#
# *: {String} Command to print and execute.
# Out: {String} Command executed and result.
# Return: Executed command exit code.

local cmd="$@"

echo >&2
@print "$(@str-repeat 80 '-')"
echo "$ ${cmd}" >&2
eval "${cmd}"
local r=$?
echo -e "$(@style reset)<END {$ ${cmd}} > ${r}" >&2
@print "$(@str-repeat 80 '-')"
echo >&2
return ${r}
