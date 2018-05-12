@@assert.noOut "@in-str 'abc' 'b'"
@@assert.noOut "@in-str 'abc' 'x'"
@@assert.noOut "@in-str 'abc' 'B' true"
@@assert.noOut "@in-str 'abc' 'b' true"
@@assert.noOut "@in-str 'abc' 'B' false"
@@assert.noOut "@in-str 'abc' 'b' false"

@@assert.exec '@in-str' true '"abc" "a"'
@@assert.exec '@in-str' true '"abc" "b"'
@@assert.exec '@in-str' true '"abc" "c"'
@@assert.exec '@in-str' true '"abc" "abc"'
@@assert.exec '@in-str' true '"abc" "ab"'
@@assert.exec '@in-str' true '"abc" "bc"'


@@assert.exec '@in-str' false '"abc" "A"'
@@assert.exec '@in-str' false '"abc" "B"'
@@assert.exec '@in-str' false '"abc" "C"'
@@assert.exec '@in-str' false '"abc" "aBc"'
@@assert.exec '@in-str' false '"abc" "aB"'
@@assert.exec '@in-str' false '"abc" "bC"'

@@assert.exec '@in-str' false '"ABC" "a"'
@@assert.exec '@in-str' false '"ABC" "b"'
@@assert.exec '@in-str' false '"ABC" "c"'
@@assert.exec '@in-str' false '"ABC" "abc"'
@@assert.exec '@in-str' false '"ABC" "ab"'
@@assert.exec '@in-str' false '"ABC" "bc"'


@@assert.exec '@in-str' true '"abc" "a" true'
@@assert.exec '@in-str' true '"abc" "b" true'
@@assert.exec '@in-str' true '"abc" "c" true'
@@assert.exec '@in-str' true '"abc" "abc" true'
@@assert.exec '@in-str' true '"abc" "ab" true'
@@assert.exec '@in-str' true '"abc" "bc" true'

@@assert.exec '@in-str' false '"abc" "A" true'
@@assert.exec '@in-str' false '"abc" "B" true'
@@assert.exec '@in-str' false '"abc" "C" true'
@@assert.exec '@in-str' false '"abc" "aBc" true'
@@assert.exec '@in-str' false '"abc" "aB" true'
@@assert.exec '@in-str' false '"abc" "bC" true'

@@assert.exec '@in-str' false '"ABC" "a" true'
@@assert.exec '@in-str' false '"ABC" "b" true'
@@assert.exec '@in-str' false '"ABC" "c" true'
@@assert.exec '@in-str' false '"ABC" "abc" true'
@@assert.exec '@in-str' false '"ABC" "ab" true'
@@assert.exec '@in-str' false '"ABC" "bc" true'


@@assert.exec '@in-str' true '"abc" "a" false'
@@assert.exec '@in-str' true '"abc" "b" false'
@@assert.exec '@in-str' true '"abc" "c" false'
@@assert.exec '@in-str' true '"abc" "abc" false'
@@assert.exec '@in-str' true '"abc" "ab" false'
@@assert.exec '@in-str' true '"abc" "bc" false'

@@assert.exec '@in-str' true '"abc" "A" false'
@@assert.exec '@in-str' true '"abc" "B" false'
@@assert.exec '@in-str' true '"abc" "C" false'
@@assert.exec '@in-str' true '"abc" "aBc" false'
@@assert.exec '@in-str' true '"abc" "aB" false'
@@assert.exec '@in-str' true '"abc" "bC" false'

@@assert.exec '@in-str' true '"ABC" "a" false'
@@assert.exec '@in-str' true '"ABC" "b" false'
@@assert.exec '@in-str' true '"ABC" "c" false'
@@assert.exec '@in-str' true '"ABC" "abc" false'@assert
@@assert.exec '@in-str' true '"ABC" "ab" false'
@@assert.exec '@in-str' true '"ABC" "bc" false'


@@assert.exec '@in-str' false '"abc" "x"'
@@assert.exec '@in-str' false '"abc" "x" true'
@@assert.exec '@in-str' false '"abc" "x" false'
