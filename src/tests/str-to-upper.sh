@@assertNoErrOut '@str-to-upper'
@@assertNoErrOut '@str-to-upper "a"'

@@assertEqual 'ABC 123 X' "$(@str-to-upper "abc 123 X")"
@@assertEqual 'ABC 123 X' "$(@str-to-upper "Abc 123 X")"
@@assertEqual 'ABC 123 X' "$(@str-to-upper "aBC 123 x")"

@@assertEmpty "$(@str-to-upper "")"
