@@assertNoErrOut '@str-replace'
@@assertNoErrOut '@str-replace "a"'
@@assertNoErrOut '@str-replace "a" "b"'
@@assertNoErrOut '@str-replace "a" "b" "c"'
@@assertNoErrOut '@str-replace "a" "b" "c"'
@@assertNoErrOut '@str-replace "a" "b" "c" true'
@@assertNoErrOut '@str-replace "a" "b" "c" false'

@@assertEqual 'xbc' "$(@str-replace "abc" "a" "x")"
@@assertEqual 'axc' "$(@str-replace "abc" "b" "x")"
@@assertEqual 'abx' "$(@str-replace "abc" "c" "x")"

@@assertEqual 'axc' "$(@str-replace "abc" "b" "x" true)"
@@assertEqual 'axc' "$(@str-replace "abc" "b" "x" false)"
@@assertEqual 'axc' "$(@str-replace "abc" "B" "x" true)"
@@assertEqual 'abc' "$(@str-replace "abc" "B" "x" false)"

@@assertEqual 'xbx' "$(@str-replace "abc" "[ac]" "x")"
@@assertEqual 'xbx' "$(@str-replace "abc" "[AC]" "x")"
@@assertEqual 'xbx' "$(@str-replace "abc" "[AC]" "x" true)"
@@assertEqual 'xbx' "$(@str-replace "abc" "[ac]" "x" false)"
@@assertEqual 'abc' "$(@str-replace "abc" "[AC]" "x" false)"

@@assertEmpty "$(@str-replace "abc" "abc" "")"
@@assertEmpty "$(@str-replace "" "a" "b")"
@@assertEmpty "$(@str-replace "abc" ".*" "")"
