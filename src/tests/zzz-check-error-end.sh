# This test should be the last executed

str='asdfg'

@@assertNoOut "@check-error-end 0 'echo ${str}'"
@@assertErrOut "@check-error-end 1 'echo ${str} >&2'"
@@assertStdOut "@check-error-end 1 'echo ${str}'"

result="$(@check-error-end 0 "echo ${str}" 2>/dev/null)"
@@assertEmpty "${result}"

result="$(@check-error-end 1 "echo ${str}" 2>/dev/null)"
@@assertEqual "${str}" "${result}"

result="$(@check-error-end 200 "echo ${str}" 2>/dev/null)"
@@assertEqual "${str}" "${result}"

result="$(@check-error-end 1 "echo ${str}" 2>/dev/null ; echo "xxx")"
@@assertEqual "${str}" "${result}"

result="$(@check-error-end 0 "echo xxx" 2>/dev/null ; echo "${str}")"
@@assertEqual "${str}" "${result}"

@@assertExec '@check-error-end' true '0 "echo xxx"'
@@assertExec '@check-error-end' false '1 "echo xxx"'
