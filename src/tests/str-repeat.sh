@@assertNoErrOut '@str-repeat'
@@assertNoErrOut '@str-repeat 0'
@@assertNoErrOut '@str-repeat 1'
@@assertNoErrOut '@str-repeat 1 "a"'

@@assertEqual 'xxxxx' "$(@str-repeat 5 x)"
@@assertEqual 'ababab' "$(@str-repeat 3 "ab")"
@@assertEqual 'ab' "$(@str-repeat 1 "ab")"
@@assertEmpty "$(@str-repeat 0 "x")"
@@assertEmpty "$(@str-repeat 10)"
@@assertEmpty "$(@str-repeat 10 "")"
