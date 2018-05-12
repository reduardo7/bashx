str='asdfg'

@@assert.noOut "@check-error 0 'echo ${str}'"
@@assert.stdOut "@check-error 1 'echo ${str}'"

result="$(@check-error 0 "echo ${str}")"
@@assert.empty "${result}"

result="$(@check-error 1 "echo ${str}")"
@@assert.equal "${str}" "${result}"

result="$(@check-error 200 "echo ${str}")"
@@assert.equal "${str}" "${result}"
