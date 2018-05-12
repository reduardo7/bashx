@@assert.noErrOut '@str-pos'
@@assert.noErrOut '@str-pos "a"'
@@assert.noErrOut '@str-pos "a" "b"'
@@assert.noErrOut '@str-pos "a" "b" true'
@@assert.noErrOut '@str-pos "a" "b" false'

@@assert.equal '0' "$(@str-pos "abc" "a")"
@@assert.equal '1' "$(@str-pos "abc" "b")"
@@assert.equal '2' "$(@str-pos "abc" "c")"
@@assert.empty "$(@str-pos "abc" "B")"
@@assert.empty "$(@str-pos "abc" "B" true)"
@@assert.equal '1' "$(@str-pos "abc" "b" false)"
@@assert.equal '1' "$(@str-pos "abc" "B" false)"

@@assert.exec '@str-pos' true '"abc" "a"'
@@assert.exec '@str-pos' true '"abc" "b"'
@@assert.exec '@str-pos' true '"abc" "c"'
@@assert.exec '@str-pos' false '"abc" "B"'
@@assert.exec '@str-pos' true '"abc" "b" true'
@@assert.exec '@str-pos' false '"abc" "B" true'
@@assert.exec '@str-pos' true '"abc" "b" false'
@@assert.exec '@str-pos' true '"abc" "B" false'
