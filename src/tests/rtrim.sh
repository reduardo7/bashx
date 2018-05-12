@@assert.noErrOut '@rtrim'
@@assert.noErrOut '@rtrim a'

@@assert.equal ' a b1' "$(@rtrim ' a b1 ')"
@@assert.equal '    a b2' "$(@rtrim '    a b2    ')"

@@assert.equal 'xxx a x b4 ' "$(@rtrim 'xxx a x b4 xxx' 'x')"
@@assert.equal 'XXX a x b5 XXX' "$(@rtrim 'XXX a x b5 XXX' 'x')"

@@assert.equal 'ab ab ' "$(@rtrim 'ab ab ab' 'ab')"
@@assert.equal 'ab' "$(@rtrim 'ab ab ab' ' ab')"
@@assert.equal 'abba' "$(@rtrim 'abbaab' 'ab')"
