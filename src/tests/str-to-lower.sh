@@assertNoErrOut '@str-to-lower'
@@assertNoErrOut '@str-to-lower "a"'

@@assertEqual 'abc 123 x' "$(@str-to-lower "abc 123 X")"
@@assertEqual 'abc 123 x' "$(@str-to-lower "Abc 123 X")"
@@assertEqual 'abc 123 x' "$(@str-to-lower "aBC 123 x")"

@@assertEmpty "$(@str-to-lower "")"
