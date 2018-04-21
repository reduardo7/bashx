@@assertNoErrOut '@trim'
@@assertNoErrOut '@trim a'

@@assertEqual 'a b1' "$(@trim ' a b1 ')"
@@assertEqual 'a b2' "$(@trim '    a b2     ')"

@@assertEqual ' a x b4 ' "$(@trim 'xxx a x b4 xxx' 'x')"
@@assertEqual 'XXX a x b5 XXX' "$(@trim 'XXX a x b5 XXX' 'x')"

@@assertEqual ' ab ' "$(@trim 'ab ab ab' 'ab')"
@@assertEqual 'ab' "$(@trim 'ab ab ab' 'ab ')"
@@assertEqual 'ba' "$(@trim 'abbaab' 'ab')"
