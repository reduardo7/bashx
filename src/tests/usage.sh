tmp_file="$(mktemp)"

echo "## First-line" > ${tmp_file}
echo "## Second-line" >> ${tmp_file}
echo "Code" >> ${tmp_file}
echo "Code" >> ${tmp_file}
echo "### no-out" >> ${tmp_file}
echo "## Other-line" >> ${tmp_file}

@@assertExec '@usage' false
@@assertExec '@usage /invalid/path/to/file/lh4' false

output="$(@usage ${tmp_file} 2>&1)"
rm -f ${tmp_file}

@@assertNotEmpty "${output}"
@@assertContains "${output}" 'First-line'
@@assertContains "${output}" 'Second-line'
@@assertContains "${output}" 'Other-line'
@@assertNotContains "${output}" 'Code'
@@assertNotContains "${output}" 'no-out'
