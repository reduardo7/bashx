@@assert.noErrOut '@str.rtrim'
@@assert.noErrOut '@str.rtrim a'

@@assert.equal ' a b1' "$(@str.rtrim ' a b1 ')"
@@assert.equal '    a b2' "$(@str.rtrim '    a b2    ')"

@@assert.equal 'xxx a x b4 ' "$(@str.rtrim 'xxx a x b4 xxx' 'x')"
@@assert.equal 'XXX a x b5 XXX' "$(@str.rtrim 'XXX a x b5 XXX' 'x')"

@@assert.equal 'ab ab ' "$(@str.rtrim 'ab ab ab' 'ab')"
@@assert.equal 'ab' "$(@str.rtrim 'ab ab ab' ' ab')"
@@assert.equal 'abba' "$(@str.rtrim 'abbaab' 'ab')"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
