@@assertNoErrOut '@ltrim'
@@assertNoErrOut '@ltrim a'

@@assertEqual 'a b1 ' "$(@ltrim ' a b1 ')"
@@assertEqual 'a b2 ' "$(@ltrim '    a b2 ')"
@@assertEqual "$(echo -e " a \t b3 \t\t")" "$(@ltrim "$(echo -e "\t\t a \t b3 \t\t")" '\t')"

@@assertEqual "$(echo -e "a \t b31 \t\t")" "$(@ltrim "$(echo -e "\t \t a \t b31 \t\t")" '[\t\s]')"

@@assertEqual ' a x b4 xxx' "$(@ltrim 'xxx a x b4 xxx' 'x')"
@@assertEqual 'XXX a x b5 XXX' "$(@ltrim 'XXX a x b5 XXX' 'x')"

@@assertEqual ' ab ab' "$(@ltrim 'ab ab ab' 'ab')"
@@assertEqual 'ab' "$(@ltrim 'ab ab ab' 'ab ')"
@@assertEqual 'baab' "$(@ltrim 'abbaab' 'ab')"
