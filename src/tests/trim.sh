@@assertNoErrOut '@trim'
@@assertNoErrOut '@trim a'

@@assertEqual 'a b1' "$(@trim ' a b1 ')"
@@assertEqual 'a b2' "$(@trim '    a b2     ')"
@@assertEqual "$(echo -e " a \t b3 ")" "$(@trim "$(echo -e "\t\t a \t b3 \t\t")" '\t')"

@@assertEqual "$(echo -e "a \t b31")" "$(@trim "$(echo -e "\t \t a \t b31 \t\t")" '[\t\s]')"

@@assertEqual ' a x b4 ' "$(@trim 'xxx a x b4 xxx' 'x')"
@@assertEqual 'XXX a x b5 XXX' "$(@trim 'XXX a x b5 XXX' 'x')"

@@assertEqual ' ab ' "$(@trim 'ab ab ab' 'ab')"
@@assertEqual 'ab' "$(@trim 'ab ab ab' 'ab ')"
@@assertEqual 'ba' "$(@trim 'abbaab' 'ab')"
