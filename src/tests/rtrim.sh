@@assertNoErrOut '@rtrim'
@@assertNoErrOut '@rtrim a'

@@assertEqual ' a b1' "$(@rtrim ' a b1 ')"
@@assertEqual '    a b2' "$(@rtrim '    a b2    ')"

@@assertEqual 'xxx a x b4 ' "$(@rtrim 'xxx a x b4 xxx' 'x')"
@@assertEqual 'XXX a x b5 XXX' "$(@rtrim 'XXX a x b5 XXX' 'x')"

@@assertEqual 'ab ab ' "$(@rtrim 'ab ab ab' 'ab')"
@@assertEqual 'ab' "$(@rtrim 'ab ab ab' ' ab')"
@@assertEqual 'abba' "$(@rtrim 'abbaab' 'ab')"
