str="my test string"
result="$(@warn "${str}" 2>&1)"

@@assertNotEmpty "${result}"
@@assertContains "${result}" "${str}"

@@assertNoStdOut "@warn 'no output this'"
@@assertErrOut "@warn 'output this'"
