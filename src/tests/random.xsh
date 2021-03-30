@@assert.noErrOut '@random'
@@assert.stdOut '@random'

@@assert.regExp '^[a-zA-Z0-9]+$' "$(@random)"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
