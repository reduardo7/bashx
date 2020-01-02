@@assert.noErrOut '@str.sub'
@@assert.noErrOut '@str.sub "a"'

@@assert.equal 'abc' "$(@str.sub "abcdefg" 3)"
@@assert.equal 'abc' "$(@str.sub "abcdefg" 3 0)"
@@assert.equal 'cde' "$(@str.sub "abcdefg" 3 2)"
@@assert.equal 'fg' "$(@str.sub "abcdefg" 3 5)"
@@assert.equal 'g' "$(@str.sub "abcdefg" 3 6)"

@@assert.empty "$(@str.sub "")"
@@assert.empty "$(@str.sub "abcdefg" 3 7)"
@@assert.empty "$(@str.sub "abcdefg" 3 10)"
@@assert.empty "$(@str.sub "abcdefg" 0 1)"
@@assert.empty "$(@str.sub "abcdefg" 0 0)"
