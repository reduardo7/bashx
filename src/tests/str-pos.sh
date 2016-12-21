@@assertNoErrOut '@str-pos'
@@assertNoErrOut '@str-pos "a"'
@@assertNoErrOut '@str-pos "a" "b"'
@@assertNoErrOut '@str-pos "a" "b" true'
@@assertNoErrOut '@str-pos "a" "b" false'

@@assertEqual '0' "$(@str-pos "abc" "a")"
@@assertEqual '1' "$(@str-pos "abc" "b")"
@@assertEqual '2' "$(@str-pos "abc" "c")"
@@assertEmpty "$(@str-pos "abc" "B")"
@@assertEmpty "$(@str-pos "abc" "B" true)"
@@assertEqual '1' "$(@str-pos "abc" "b" false)"
@@assertEqual '1' "$(@str-pos "abc" "B" false)"

@@assertExec '@str-pos' true '"abc" "a"'
@@assertExec '@str-pos' true '"abc" "b"'
@@assertExec '@str-pos' true '"abc" "c"'
@@assertExec '@str-pos' false '"abc" "B"'
@@assertExec '@str-pos' true '"abc" "b" true'
@@assertExec '@str-pos' false '"abc" "B" true'
@@assertExec '@str-pos' true '"abc" "b" false'
@@assertExec '@str-pos' true '"abc" "B" false'
