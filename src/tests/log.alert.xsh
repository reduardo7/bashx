str="my test string"
style_color_red="$(@style color:red)"
result="$(@log.alert "${str}" 2>&1)"

@@assert.notEmpty "${result}"
@@assert.contains "${result}" "${style_color_red}"
@@assert.contains "${result}" "${str}"

@@assert.noStdOut "@log.alert 'no output this'"
@@assert.errOut "@log.alert 'output this'"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
