@@assertNoErrOut '@random'
@@assertStdOut '@random'

@@assertRegExp '^[a-zA-Z0-9]+$' "$(@random)"
