@@assert.noErrOut '@str.ltrim'
@@assert.noErrOut '@str.ltrim a'

@@assert.equal 'a b1 ' "$(@str.ltrim ' a b1 ')"
@@assert.equal 'a b2 ' "$(@str.ltrim '    a b2 ')"
@@assert.equal ' a x b4 xxx' "$(@str.ltrim 'xxx a x b4 xxx' 'x')"
@@assert.equal 'XXX a x b5 XXX' "$(@str.ltrim 'XXX a x b5 XXX' 'x')"

@@assert.equal ' ab ab' "$(@str.ltrim 'ab ab ab' 'ab')"
@@assert.equal 'ab' "$(@str.ltrim 'ab ab ab' 'ab ')"
@@assert.equal 'baab' "$(@str.ltrim 'abbaab' 'ab')"
