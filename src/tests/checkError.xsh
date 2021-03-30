str='asdfg'

@@assert.noOut "@checkError 0 'echo ${str}'"
@@assert.stdOut "@checkError 1 'echo ${str}'"

result="$(@checkError 0 "echo ${str}")"
@@assert.empty "${result}"

result="$(@checkError 1 "echo ${str}")"
@@assert.equal "${str}" "${result}"

result="$(@checkError 200 "echo ${str}")"
@@assert.equal "${str}" "${result}"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
