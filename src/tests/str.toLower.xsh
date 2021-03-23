@@assert.noErrOut '@str.toLower'
@@assert.noErrOut '@str.toLower "a"'

@@assert.equal 'abc 123 x' "$(@str.toLower "abc 123 X")"
@@assert.equal 'abc 123 x' "$(@str.toLower "Abc 123 X")"
@@assert.equal 'abc 123 x' "$(@str.toLower "aBC 123 x")"

@@assert.empty "$(@str.toLower "")"
