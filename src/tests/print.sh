output="$(@print 'no print' 3>/dev/null)"
@@assertEmpty "${output}"

output="$(@print "foo\tbar" 3>&1)"
@@assertNotEmpty "${output}"
@@assertNotContains "${output}" "foo\tbar"
@@assertContains "${output}" 'foo'
@@assertContains "${output}" 'bar'
@@assertContains "${output}" "${ECHO_CHAR}"
@@assertEndWith "${output}" "$(@style reset)"
