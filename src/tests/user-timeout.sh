$OS_IS_MAC && exit 0

tmp_file="$(mktemp)"
[ -f "${tmp_file}" ] && rm -f ${tmp_file}

cmd_touch="touch ${tmp_file}"

# Wait 1 second
@cmd-log "@user-timeout 1 '${cmd_touch}'" 3>/dev/null
[ ! -f "${tmp_file}" ] && @@assertFail "${cmd_touch} has not been created!"
rm -f ${tmp_file} || @@asserFail "Error deleting ${tmp_file}!"

# User input lower 'c'
@cmd-log "echo 'c' | @user-timeout 2 '${cmd_touch} ; echo NO PRINT THIS'" 3>/dev/null
[ -f "${tmp_file}" ] && @@assertFail "${cmd_touch} should not have been created!"

# User input uppser 'C'
@cmd-log "echo 'C' | @user-timeout 2 '${cmd_touch} ; echo NO PRINT THIS'" 3>/dev/null
[ -f "${tmp_file}" ] && @@assertFail "${cmd_touch} should not have been created!"

# User input ESC
@cmd-log "echo -e \"\${KEY_ESC}\" | @user-timeout 2 '${cmd_touch} ; echo NO PRINT THIS'" 3>/dev/null
[ -f "${tmp_file}" ] && @@assertFail "${cmd_touch} should not have been created!"

# All ok
exit 0
