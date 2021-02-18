# This test should be the last executed

str='asdfg'

@@assert.noOut "@checkErrorEnd 0 'echo ${str}'"
@@assert.errOut "@checkErrorEnd 1 'echo ${str} >&2'"
@@assert.stdOut "@checkErrorEnd 1 'echo ${str}'"

result="$(@checkErrorEnd 0 "echo ${str}" 2>/dev/null)"
@@assert.empty "${result}"

result="$(@checkErrorEnd 1 "echo ${str}" 2>/dev/null)"
@@assert.equal "${str}" "${result}"

result="$(@checkErrorEnd 200 "echo ${str}" 2>/dev/null)"
@@assert.equal "${str}" "${result}"

result="$(@checkErrorEnd 1 "echo ${str}" 2>/dev/null ; echo "xxx")"
@@assert.equal "${str}" "${result}"

result="$(@checkErrorEnd 0 "echo xxx" 2>/dev/null ; echo "${str}")"
@@assert.equal "${str}" "${result}"

@@assert.exec '@checkErrorEnd' true '0 "echo xxx"'
@@assert.exec '@checkErrorEnd' false '1 "echo xxx"'
