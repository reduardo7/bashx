@@assert.noOut '@function.void'
@@assert.noOut '@function.void "a" "b"'

code="$(@function.void ; echo $?)"
@@assert.notErrorCode $code
