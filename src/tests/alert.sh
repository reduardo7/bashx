str="my test string"
style_color_red="$(@style color:red)"
result="$(@alert "${str}" 2>&1)"

@@assertNotEmpty "${result}"
@@assertContains "${result}" "${style_color_red}"
@@assertContains "${result}" "${str}"

@@assertNoStdOut "@alert 'no output this'"
@@assertErrOut "@alert 'output this'"
