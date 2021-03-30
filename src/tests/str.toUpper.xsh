@@assert.noErrOut '@str.toUpper'
@@assert.noErrOut '@str.toUpper "a"'

@@assert.equal 'ABC 123 X' "$(@str.toUpper "abc 123 X")"
@@assert.equal 'ABC 123 X' "$(@str.toUpper "Abc 123 X")"
@@assert.equal 'ABC 123 X' "$(@str.toUpper "aBC 123 x")"

@@assert.empty "$(@str.toUpper "")"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
