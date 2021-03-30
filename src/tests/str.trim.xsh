@@assert.noErrOut '@str.trim'
@@assert.noErrOut '@str.trim a'

@@assert.equal 'a b1' "$(@str.trim ' a b1 ')"
@@assert.equal 'a b2' "$(@str.trim '    a b2     ')"

@@assert.equal ' a x b4 ' "$(@str.trim 'xxx a x b4 xxx' 'x')"
@@assert.equal 'XXX a x b5 XXX' "$(@str.trim 'XXX a x b5 XXX' 'x')"

@@assert.equal ' ab ' "$(@str.trim 'ab ab ab' 'ab')"
@@assert.equal 'ab' "$(@str.trim 'ab ab ab' 'ab ')"
@@assert.equal 'ba' "$(@str.trim 'abbaab' 'ab')"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
