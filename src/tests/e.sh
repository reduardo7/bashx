output="$(@e 'no print' 2>/dev/null)"
@@assertEmpty "${output}"

output="$(@e "foo\tbar" 2>&1)"
@@assertNotEmpty "${output}"
@@assertNotContains "${output}" "foo\tbar"
@@assertContains "${output}" 'foo'
@@assertContains "${output}" 'bar'
@@assertContains "${output}" "${ECHO_CHAR}"
@@assertEndWith "${output}" "$(@style reset)"
