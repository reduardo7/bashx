@@assertNoErrOut '@str-len'
@@assertNoErrOut '@str-len "a"'

sl="$(@str-len "$(@style color:blue)abc$(@style color:default) ")"

@@assertNumber "${sl}"

[[ ${sl} -eq 4 ]] || @@assertFail "Str-Len: ${sl} != 4"
