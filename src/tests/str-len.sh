@@assert.noErrOut '@str-len'
@@assert.noErrOut '@str-len "a"'

sl="$(@str-len "$(@style color:blue)abc$(@style color:default) ")"

@@assert.number "${sl}"

[[ ${sl} -eq 4 ]] || @@assert.fail "Str-Len: ${sl} != 4"
