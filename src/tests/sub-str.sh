@@assertNoErrOut '@sub-str'
@@assertNoErrOut '@sub-str "a"'

@@assertEqual 'abc' "$(@sub-str "abcdefg" 3)"
@@assertEqual 'abc' "$(@sub-str "abcdefg" 3 0)"
@@assertEqual 'cde' "$(@sub-str "abcdefg" 3 2)"
@@assertEqual 'fg' "$(@sub-str "abcdefg" 3 5)"
@@assertEqual 'g' "$(@sub-str "abcdefg" 3 6)"

@@assertEmpty "$(@sub-str "")"
@@assertEmpty "$(@sub-str "abcdefg" 3 7)"
@@assertEmpty "$(@sub-str "abcdefg" 3 10)"
@@assertEmpty "$(@sub-str "abcdefg" 0 1)"
@@assertEmpty "$(@sub-str "abcdefg" 0 0)"
