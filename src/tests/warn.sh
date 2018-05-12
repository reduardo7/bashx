str="my test string"
result="$(@warn "${str}" 2>&1)"

@@assert.notEmpty "${result}"
@@assert.contains "${result}" "${str}"

@@assert.noStdOut "@warn 'no output this'"
@@assert.errOut "@warn 'output this'"
