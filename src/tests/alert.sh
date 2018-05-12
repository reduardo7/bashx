str="my test string"
style_color_red="$(@style color:red)"
result="$(@alert "${str}" 2>&1)"

@@assert.notEmpty "${result}"
@@assert.contains "${result}" "${style_color_red}"
@@assert.contains "${result}" "${str}"

@@assert.noStdOut "@alert 'no output this'"
@@assert.errOut "@alert 'output this'"
