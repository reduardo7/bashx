@@assertExec "@@assertFail" false
@@assertExec "@@assertFail" false '"asd"'

@@assertExec "@@assertTrue" true true
@@assertExec "@@assertTrue" false false
@@assertExec "@@assertTrue" false '"x"'

@@assertExec "@@assertFalse" true false
@@assertExec "@@assertFalse" false true
@@assertExec "@@assertFalse" false '"x"'

@@assertExec "@@assertEmpty" true '""'
@@assertExec "@@assertEmpty" false '"x"'
@@assertExec "@@assertEmpty" false '"${KEY_ESC}"'
@@assertExec "@@assertEmpty" false '" "'
@@assertExec "@@assertEmpty" false '"\t"'
@@assertExec "@@assertEmpty" false '"\n"'

@@assertExec "@@assertNotEmpty" true 'x'
@@assertExec "@@assertNotEmpty" true '" "'
@@assertExec "@@assertNotEmpty" true '"\t"'
@@assertExec "@@assertNotEmpty" true '"\n"'
@@assertExec "@@assertNotEmpty" true '"${KEY_ESC}"'
@@assertExec "@@assertNotEmpty" false '""'

@@assertExec "@@assertNumber" true '1'
@@assertExec "@@assertNumber" true '0'
@@assertExec "@@assertNumber" true '00'
@@assertExec "@@assertNumber" true '10'
@@assertExec "@@assertNumber" true '5'
@@assertExec "@@assertNumber" false '-1'
@@assertExec "@@assertNumber" false '""'
@@assertExec "@@assertNumber" false '" "'
@@assertExec "@@assertNumber" false '" 1"'
@@assertExec "@@assertNumber" false '"1 "'
@@assertExec "@@assertNumber" false '"1 1"'
@@assertExec "@@assertNumber" false 'x'

@@assertExec "@@assertErrorCode" true '1'
@@assertExec "@@assertErrorCode" true '10'
@@assertExec "@@assertErrorCode" true '255'
@@assertExec "@@assertErrorCode" false '256'
@@assertExec "@@assertErrorCode" false '300'
@@assertExec "@@assertErrorCode" false '0'
@@assertExec "@@assertErrorCode" false '""'
@@assertExec "@@assertErrorCode" false '" "'
@@assertExec "@@assertErrorCode" false 'x'
@@assertExec "@@assertErrorCode" false '"1 "'
@@assertExec "@@assertErrorCode" false '" 1"'
@@assertExec "@@assertErrorCode" false '"1 1"'

@@assertExec "@@assertNotErrorCode" true '0'
@@assertExec "@@assertNotErrorCode" false '1'
@@assertExec "@@assertNotErrorCode" false '10'
@@assertExec "@@assertNotErrorCode" false '255'
@@assertExec "@@assertNotErrorCode" false '300'
@@assertExec "@@assertNotErrorCode" false '""'
@@assertExec "@@assertNotErrorCode" false '" "'
@@assertExec "@@assertNotErrorCode" false 'x'
@@assertExec "@@assertNotErrorCode" false '"1 "'
@@assertExec "@@assertNotErrorCode" false '" 1"'
@@assertExec "@@assertNotErrorCode" false '"1 1"'

@@assertExec "@@assertEqual" true '1 1'
@@assertExec "@@assertEqual" true 'a a'
@@assertExec "@@assertEqual" true '0 0'
@@assertExec "@@assertEqual" true '"" ""'
@@assertExec "@@assertEqual" true '"${KEY_ESC}" "${KEY_ESC}"'
@@assertExec "@@assertEqual" false 'a A'
@@assertExec "@@assertEqual" false 'A a'
@@assertExec "@@assertEqual" false '"" 0'

@@assertExec "@@assertNotEqual" true 'a A'
@@assertExec "@@assertNotEqual" true 'A a'
@@assertExec "@@assertNotEqual" true '"" 0'
@@assertExec "@@assertNotEqual" false '1 1'
@@assertExec "@@assertNotEqual" false 'a a'
@@assertExec "@@assertNotEqual" false '0 0'
@@assertExec "@@assertNotEqual" false '"" ""'
@@assertExec "@@assertNotEqual" false '"${KEY_ESC}" "${KEY_ESC}"'

@@assertExec "@@assertContains" true 'abc b'
@@assertExec "@@assertContains" true 'abc a'
@@assertExec "@@assertContains" true 'abc c'
@@assertExec "@@assertContains" true 'abc bc'
@@assertExec "@@assertContains" true 'abc abc'
@@assertExec "@@assertContains" false '"" ""'
@@assertExec "@@assertContains" false 'abc x'
@@assertExec "@@assertContains" false 'abc A'
@@assertExec "@@assertContains" false 'abc ""'
@@assertExec "@@assertContains" false 'abc B'

@@assertExec "@@assertNotContains" true 'abc x'
@@assertExec "@@assertNotContains" true 'abc A'
@@assertExec "@@assertNotContains" true 'abc B'
@@assertExec "@@assertNotContains" false 'abc ""'
@@assertExec "@@assertNotContains" false '"" ""'
@@assertExec "@@assertNotContains" false 'abc b'
@@assertExec "@@assertNotContains" false 'abc a'
@@assertExec "@@assertNotContains" false 'abc c'
@@assertExec "@@assertNotContains" false 'abc bc'
@@assertExec "@@assertNotContains" false 'abc abc'

@@assertExec "@@assertStdOut" true '"echo asd"'
@@assertExec "@@assertStdOut" true '"echo \"${KEY_ESC}\""'
@@assertExec "@@assertStdOut" false '"echo asd >&2"'
@@assertExec "@@assertStdOut" false '"echo"'

@@assertExec "@@assertNoStdOut" true '"echo asd >&2"'
@@assertExec "@@assertNoStdOut" true '"echo"'
@@assertExec "@@assertNoStdOut" false '"echo asd"'
@@assertExec "@@assertNoStdOut" false '"echo \"${KEY_ESC}\""'

@@assertExec "@@assertErrOut" true '"echo asd >&2"'
@@assertExec "@@assertErrOut" true '"echo \"${KEY_ESC}\" >&2"'
@@assertExec "@@assertErrOut" false '"echo"'
@@assertExec "@@assertErrOut" false '"echo asd"'

@@assertExec "@@assertNoErrOut" true '"echo"'
@@assertExec "@@assertNoErrOut" true '"echo asd"'
@@assertExec "@@assertNoErrOut" false '"echo asd >&2"'
@@assertExec "@@assertNoErrOut" false '"echo \"${KEY_ESC}\" >&2"'

@@assertExec "@@assertNoOut" true '"echo"'
@@assertExec "@@assertNoOut" false '"echo asd"'
@@assertExec "@@assertNoOut" false '"echo asd >&2"'
@@assertExec "@@assertNoOut" false '"echo \"${KEY_ESC}\""'
@@assertExec "@@assertNoOut" false '"echo \"${KEY_ESC}\" >&2"'
