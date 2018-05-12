# This test should be the last executed

str='asdfg'

@@assert.noOut "@check-error-end 0 'echo ${str}'"
@@assert.errOut "@check-error-end 1 'echo ${str} >&2'"
@@assert.stdOut "@check-error-end 1 'echo ${str}'"

result="$(@check-error-end 0 "echo ${str}" 2>/dev/null)"
@@assert.empty "${result}"

result="$(@check-error-end 1 "echo ${str}" 2>/dev/null)"
@@assert.equal "${str}" "${result}"

result="$(@check-error-end 200 "echo ${str}" 2>/dev/null)"
@@assert.equal "${str}" "${result}"

result="$(@check-error-end 1 "echo ${str}" 2>/dev/null ; echo "xxx")"
@@assert.equal "${str}" "${result}"

result="$(@check-error-end 0 "echo xxx" 2>/dev/null ; echo "${str}")"
@@assert.equal "${str}" "${result}"

@@assert.exec '@check-error-end' true '0 "echo xxx"'
@@assert.exec '@check-error-end' false '1 "echo xxx"'
