@@assertNoOut '@void'
@@assertNoOut '@void "a" "b"'

code="$(@void ; echo $?)"
@@assertNotErrorCode $code
