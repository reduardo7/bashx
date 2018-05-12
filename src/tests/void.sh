@@assert.noOut '@void'
@@assert.noOut '@void "a" "b"'

code="$(@void ; echo $?)"
@@assert.notErrorCode $code
