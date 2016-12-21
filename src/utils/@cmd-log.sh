# Print command and their result.
#
# *: {String} Command to print and execute.
# Out: {String} Command executed and result.
# Return: Executed command exit code.

local cmd="$@"

echo >&3
@print "$(@str-repeat 80 '-')"
echo "$ ${cmd}" >&3
eval "${cmd}"
local r=$?
echo -e "$(@style reset)<END {$ ${cmd}} > ${r}" >&3
@print "$(@str-repeat 80 '-')"
echo >&3
return ${r}
