@@assertNoErrOut '@ltrim'
@@assertNoErrOut '@ltrim a'

@@assertEqual 'a b1 ' "$(@ltrim ' a b1 ')"
@@assertEqual 'a b2 ' "$(@ltrim '    a b2 ')"
@@assertEqual ' a x b4 xxx' "$(@ltrim 'xxx a x b4 xxx' 'x')"
@@assertEqual 'XXX a x b5 XXX' "$(@ltrim 'XXX a x b5 XXX' 'x')"

@@assertEqual ' ab ab' "$(@ltrim 'ab ab ab' 'ab')"
@@assertEqual 'ab' "$(@ltrim 'ab ab ab' 'ab ')"
@@assertEqual 'baab' "$(@ltrim 'abbaab' 'ab')"
