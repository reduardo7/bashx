@@assert.noErrOut '@random'
@@assert.stdOut '@random'

@@assert.regExp '^[a-zA-Z0-9]+$' "$(@random)"
