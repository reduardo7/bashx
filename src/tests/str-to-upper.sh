@@assert.noErrOut '@str-to-upper'
@@assert.noErrOut '@str-to-upper "a"'

@@assert.equal 'ABC 123 X' "$(@str-to-upper "abc 123 X")"
@@assert.equal 'ABC 123 X' "$(@str-to-upper "Abc 123 X")"
@@assert.equal 'ABC 123 X' "$(@str-to-upper "aBC 123 x")"

@@assert.empty "$(@str-to-upper "")"
