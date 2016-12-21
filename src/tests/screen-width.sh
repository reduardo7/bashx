@@assertNoErrOut '@screen-width'
@@assertStdOut '@screen-width'

sw="$(@screen-width)"

@@assertNumber "${sw}"

[[ ${sw} -gt 0 ]] || @@assertFail "Screen Width: ${sw} <= 0"
