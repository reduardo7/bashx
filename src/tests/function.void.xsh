@@assert.noOut '@function.void'
@@assert.noOut '@function.void "a" "b"'

code="$(@function.void ; echo $?)"
@@assert.notErrorCode $code

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
