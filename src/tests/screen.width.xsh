@@assert.noErrOut '@screen.width'
@@assert.stdOut '@screen.width'

sw="$(@screen.width)"

@@assert.number "${sw}"

[[ ${sw} -gt 0 ]] || @@assert.fail "Screen Width: ${sw} <= 0"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
