@@assertNoOut "@in-str 'abc' 'b'"
@@assertNoOut "@in-str 'abc' 'x'"
@@assertNoOut "@in-str 'abc' 'B' true"
@@assertNoOut "@in-str 'abc' 'b' true"
@@assertNoOut "@in-str 'abc' 'B' false"
@@assertNoOut "@in-str 'abc' 'b' false"

@@assertExec '@in-str' true '"abc" "a"'
@@assertExec '@in-str' true '"abc" "b"'
@@assertExec '@in-str' true '"abc" "c"'
@@assertExec '@in-str' true '"abc" "abc"'
@@assertExec '@in-str' true '"abc" "ab"'
@@assertExec '@in-str' true '"abc" "bc"'


@@assertExec '@in-str' false '"abc" "A"'
@@assertExec '@in-str' false '"abc" "B"'
@@assertExec '@in-str' false '"abc" "C"'
@@assertExec '@in-str' false '"abc" "aBc"'
@@assertExec '@in-str' false '"abc" "aB"'
@@assertExec '@in-str' false '"abc" "bC"'

@@assertExec '@in-str' false '"ABC" "a"'
@@assertExec '@in-str' false '"ABC" "b"'
@@assertExec '@in-str' false '"ABC" "c"'
@@assertExec '@in-str' false '"ABC" "abc"'
@@assertExec '@in-str' false '"ABC" "ab"'
@@assertExec '@in-str' false '"ABC" "bc"'


@@assertExec '@in-str' true '"abc" "a" true'
@@assertExec '@in-str' true '"abc" "b" true'
@@assertExec '@in-str' true '"abc" "c" true'
@@assertExec '@in-str' true '"abc" "abc" true'
@@assertExec '@in-str' true '"abc" "ab" true'
@@assertExec '@in-str' true '"abc" "bc" true'

@@assertExec '@in-str' false '"abc" "A" true'
@@assertExec '@in-str' false '"abc" "B" true'
@@assertExec '@in-str' false '"abc" "C" true'
@@assertExec '@in-str' false '"abc" "aBc" true'
@@assertExec '@in-str' false '"abc" "aB" true'
@@assertExec '@in-str' false '"abc" "bC" true'

@@assertExec '@in-str' false '"ABC" "a" true'
@@assertExec '@in-str' false '"ABC" "b" true'
@@assertExec '@in-str' false '"ABC" "c" true'
@@assertExec '@in-str' false '"ABC" "abc" true'
@@assertExec '@in-str' false '"ABC" "ab" true'
@@assertExec '@in-str' false '"ABC" "bc" true'


@@assertExec '@in-str' true '"abc" "a" false'
@@assertExec '@in-str' true '"abc" "b" false'
@@assertExec '@in-str' true '"abc" "c" false'
@@assertExec '@in-str' true '"abc" "abc" false'
@@assertExec '@in-str' true '"abc" "ab" false'
@@assertExec '@in-str' true '"abc" "bc" false'

@@assertExec '@in-str' true '"abc" "A" false'
@@assertExec '@in-str' true '"abc" "B" false'
@@assertExec '@in-str' true '"abc" "C" false'
@@assertExec '@in-str' true '"abc" "aBc" false'
@@assertExec '@in-str' true '"abc" "aB" false'
@@assertExec '@in-str' true '"abc" "bC" false'

@@assertExec '@in-str' true '"ABC" "a" false'
@@assertExec '@in-str' true '"ABC" "b" false'
@@assertExec '@in-str' true '"ABC" "c" false'
@@assertExec '@in-str' true '"ABC" "abc" false'@assert
@@assertExec '@in-str' true '"ABC" "ab" false'
@@assertExec '@in-str' true '"ABC" "bc" false'


@@assertExec '@in-str' false '"abc" "x"'
@@assertExec '@in-str' false '"abc" "x" true'
@@assertExec '@in-str' false '"abc" "x" false'
