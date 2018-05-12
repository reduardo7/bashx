@@assert.noErrOut '@ltrim'
@@assert.noErrOut '@ltrim a'

@@assert.equal 'a b1 ' "$(@ltrim ' a b1 ')"
@@assert.equal 'a b2 ' "$(@ltrim '    a b2 ')"
@@assert.equal ' a x b4 xxx' "$(@ltrim 'xxx a x b4 xxx' 'x')"
@@assert.equal 'XXX a x b5 XXX' "$(@ltrim 'XXX a x b5 XXX' 'x')"

@@assert.equal ' ab ab' "$(@ltrim 'ab ab ab' 'ab')"
@@assert.equal 'ab' "$(@ltrim 'ab ab ab' 'ab ')"
@@assert.equal 'baab' "$(@ltrim 'abbaab' 'ab')"
