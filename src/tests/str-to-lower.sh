@@assert.noErrOut '@str-to-lower'
@@assert.noErrOut '@str-to-lower "a"'

@@assert.equal 'abc 123 x' "$(@str-to-lower "abc 123 X")"
@@assert.equal 'abc 123 x' "$(@str-to-lower "Abc 123 X")"
@@assert.equal 'abc 123 x' "$(@str-to-lower "aBC 123 x")"

@@assert.empty "$(@str-to-lower "")"
