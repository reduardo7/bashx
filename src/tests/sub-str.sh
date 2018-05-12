@@assert.noErrOut '@sub-str'
@@assert.noErrOut '@sub-str "a"'

@@assert.equal 'abc' "$(@sub-str "abcdefg" 3)"
@@assert.equal 'abc' "$(@sub-str "abcdefg" 3 0)"
@@assert.equal 'cde' "$(@sub-str "abcdefg" 3 2)"
@@assert.equal 'fg' "$(@sub-str "abcdefg" 3 5)"
@@assert.equal 'g' "$(@sub-str "abcdefg" 3 6)"

@@assert.empty "$(@sub-str "")"
@@assert.empty "$(@sub-str "abcdefg" 3 7)"
@@assert.empty "$(@sub-str "abcdefg" 3 10)"
@@assert.empty "$(@sub-str "abcdefg" 0 1)"
@@assert.empty "$(@sub-str "abcdefg" 0 0)"
