@@assert.noErrOut '@trim'
@@assert.noErrOut '@trim a'

@@assert.equal 'a b1' "$(@trim ' a b1 ')"
@@assert.equal 'a b2' "$(@trim '    a b2     ')"

@@assert.equal ' a x b4 ' "$(@trim 'xxx a x b4 xxx' 'x')"
@@assert.equal 'XXX a x b5 XXX' "$(@trim 'XXX a x b5 XXX' 'x')"

@@assert.equal ' ab ' "$(@trim 'ab ab ab' 'ab')"
@@assert.equal 'ab' "$(@trim 'ab ab ab' 'ab ')"
@@assert.equal 'ba' "$(@trim 'abbaab' 'ab')"
