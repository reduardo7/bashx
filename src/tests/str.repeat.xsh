@@assert.noErrOut '@str.repeat'
@@assert.noErrOut '@str.repeat 0'
@@assert.noErrOut '@str.repeat 1'
@@assert.noErrOut '@str.repeat 1 "a"'

@@assert.equal 'xxxxx' "$(@str.repeat 5 x)"
@@assert.equal 'ababab' "$(@str.repeat 3 "ab")"
@@assert.equal 'ab' "$(@str.repeat 1 "ab")"
@@assert.empty "$(@str.repeat 0 "x")"
@@assert.empty "$(@str.repeat 10)"
@@assert.empty "$(@str.repeat 10 "")"
