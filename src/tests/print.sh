output="$(@print 'no print' 3>/dev/null)"
@@assert.empty "${output}"

output="$(@print "foo\tbar" 3>&1)"
@@assert.notEmpty "${output}"
@@assert.notContains "${output}" "foo  bar"
@@assert.contains "${output}" 'foo'
@@assert.contains "${output}" 'bar'
@@assert.contains "${output}" "${BX_APP_PRINT_PREFIX}"
@@assert.endWith "${output}" "$(@style reset)"
