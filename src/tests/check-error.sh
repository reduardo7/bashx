str='asdfg'

@@assertNoOut "@check-error 0 'echo ${str}'"
@@assertStdOut "@check-error 1 'echo ${str}'"

result="$(@check-error 0 "echo ${str}")"
@@assertEmpty "${result}"

result="$(@check-error 1 "echo ${str}")"
@@assertEqual "${str}" "${result}"

result="$(@check-error 200 "echo ${str}")"
@@assertEqual "${str}" "${result}"
