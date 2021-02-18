@@assert.noOut "@str.in 'abc' 'b'"
@@assert.noOut "@str.in 'abc' 'x'"
@@assert.noOut "@str.in 'abc' 'B' true"
@@assert.noOut "@str.in 'abc' 'b' true"
@@assert.noOut "@str.in 'abc' 'B' false"
@@assert.noOut "@str.in 'abc' 'b' false"

@@assert.exec '@str.in' true '"abc" "a"'
@@assert.exec '@str.in' true '"abc" "b"'
@@assert.exec '@str.in' true '"abc" "c"'
@@assert.exec '@str.in' true '"abc" "abc"'
@@assert.exec '@str.in' true '"abc" "ab"'
@@assert.exec '@str.in' true '"abc" "bc"'


@@assert.exec '@str.in' false '"abc" "A"'
@@assert.exec '@str.in' false '"abc" "B"'
@@assert.exec '@str.in' false '"abc" "C"'
@@assert.exec '@str.in' false '"abc" "aBc"'
@@assert.exec '@str.in' false '"abc" "aB"'
@@assert.exec '@str.in' false '"abc" "bC"'

@@assert.exec '@str.in' false '"ABC" "a"'
@@assert.exec '@str.in' false '"ABC" "b"'
@@assert.exec '@str.in' false '"ABC" "c"'
@@assert.exec '@str.in' false '"ABC" "abc"'
@@assert.exec '@str.in' false '"ABC" "ab"'
@@assert.exec '@str.in' false '"ABC" "bc"'


@@assert.exec '@str.in' true '"abc" "a" true'
@@assert.exec '@str.in' true '"abc" "b" true'
@@assert.exec '@str.in' true '"abc" "c" true'
@@assert.exec '@str.in' true '"abc" "abc" true'
@@assert.exec '@str.in' true '"abc" "ab" true'
@@assert.exec '@str.in' true '"abc" "bc" true'

@@assert.exec '@str.in' false '"abc" "A" true'
@@assert.exec '@str.in' false '"abc" "B" true'
@@assert.exec '@str.in' false '"abc" "C" true'
@@assert.exec '@str.in' false '"abc" "aBc" true'
@@assert.exec '@str.in' false '"abc" "aB" true'
@@assert.exec '@str.in' false '"abc" "bC" true'

@@assert.exec '@str.in' false '"ABC" "a" true'
@@assert.exec '@str.in' false '"ABC" "b" true'
@@assert.exec '@str.in' false '"ABC" "c" true'
@@assert.exec '@str.in' false '"ABC" "abc" true'
@@assert.exec '@str.in' false '"ABC" "ab" true'
@@assert.exec '@str.in' false '"ABC" "bc" true'


@@assert.exec '@str.in' true '"abc" "a" false'
@@assert.exec '@str.in' true '"abc" "b" false'
@@assert.exec '@str.in' true '"abc" "c" false'
@@assert.exec '@str.in' true '"abc" "abc" false'
@@assert.exec '@str.in' true '"abc" "ab" false'
@@assert.exec '@str.in' true '"abc" "bc" false'

@@assert.exec '@str.in' true '"abc" "A" false'
@@assert.exec '@str.in' true '"abc" "B" false'
@@assert.exec '@str.in' true '"abc" "C" false'
@@assert.exec '@str.in' true '"abc" "aBc" false'
@@assert.exec '@str.in' true '"abc" "aB" false'
@@assert.exec '@str.in' true '"abc" "bC" false'

@@assert.exec '@str.in' true '"ABC" "a" false'
@@assert.exec '@str.in' true '"ABC" "b" false'
@@assert.exec '@str.in' true '"ABC" "c" false'
@@assert.exec '@str.in' true '"ABC" "abc" false'@assert
@@assert.exec '@str.in' true '"ABC" "ab" false'
@@assert.exec '@str.in' true '"ABC" "bc" false'


@@assert.exec '@str.in' false '"abc" "x"'
@@assert.exec '@str.in' false '"abc" "x" true'
@@assert.exec '@str.in' false '"abc" "x" false'
