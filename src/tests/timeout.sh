tmp_file="$(mktemp)"
[ -f "${tmp_file}" ] && rm -f ${tmp_file}

cmd_touch="touch ${tmp_file}"

# Wait 1 second
@cmd-log "@timeout 1 '${cmd_touch}'"
[ ! -f "${tmp_file}" ] && @@assertFail "${cmd_touch} has not been created!"
rm -f ${tmp_file} || @@asserFail "Error deleting ${tmp_file}!"

# User input lower 'c'
@cmd-log "echo 'c' | @timeout 2 '${cmd_touch} ; echo NO PRINT THIS'"
[ -f "${tmp_file}" ] && @@assertFail "${cmd_touch} should not have been created!"

# User input uppser 'C'
@cmd-log "echo 'C' | @timeout 2 '${cmd_touch} ; echo NO PRINT THIS'"
[ -f "${tmp_file}" ] && @@assertFail "${cmd_touch} should not have been created!"

# User input ESC
@cmd-log "echo -e \"\${KEY_ESC}\" | @timeout 2 '${cmd_touch} ; echo NO PRINT THIS'"
[ -f "${tmp_file}" ] && @@assertFail "${cmd_touch} should not have been created!"

# All ok
exit 0
