str="my test string"
result="$(@log.warn "${str}" 2>&1)"

@@assert.notEmpty "${result}"
@@assert.contains "${result}" "${str}"

@@assert.noStdOut "@log.warn 'no output this'"
@@assert.errOut "@log.warn 'output this'"
