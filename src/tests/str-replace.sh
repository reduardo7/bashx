@@assert.noErrOut '@str-replace'
@@assert.noErrOut '@str-replace "a"'
@@assert.noErrOut '@str-replace "a" "b"'
@@assert.noErrOut '@str-replace "a" "b" "c"'
@@assert.noErrOut '@str-replace "a" "b" "c"'
@@assert.noErrOut '@str-replace "a" "b" "c" true'
@@assert.noErrOut '@str-replace "a" "b" "c" false'

@@assert.equal 'xbc' "$(@str-replace "abc" "a" "x")"
@@assert.equal 'axc' "$(@str-replace "abc" "b" "x")"
@@assert.equal 'abx' "$(@str-replace "abc" "c" "x")"

@@assert.equal 'axc' "$(@str-replace "abc" "b" "x" true)"
@@assert.equal 'axc' "$(@str-replace "abc" "b" "x" false)"
@@assert.equal 'axc' "$(@str-replace "abc" "B" "x" true)"
@@assert.equal 'abc' "$(@str-replace "abc" "B" "x" false)"

@@assert.equal 'xbx' "$(@str-replace "abc" "[ac]" "x")"
@@assert.equal 'xbx' "$(@str-replace "abc" "[AC]" "x")"
@@assert.equal 'xbx' "$(@str-replace "abc" "[AC]" "x" true)"
@@assert.equal 'xbx' "$(@str-replace "abc" "[ac]" "x" false)"
@@assert.equal 'abc' "$(@str-replace "abc" "[AC]" "x" false)"

@@assert.empty "$(@str-replace "abc" "abc" "")"
@@assert.empty "$(@str-replace "" "a" "b")"
@@assert.empty "$(@str-replace "abc" ".*" "")"
