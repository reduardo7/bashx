$BX_OS_IS_MAC && return 0

tmp_file="$(@mktemp false)"

cmd_touch="touch ${tmp_file}"

# Wait 1 second
@log.cmd "@user.timeout 1 '${cmd_touch}'" 3>/dev/null
[ ! -f "${tmp_file}" ] && @@assert.fail "${cmd_touch} has not been created!"
rm -f ${tmp_file} || @@assert.fail "Error deleting ${tmp_file}!"

# User input lower 'c'
@log.cmd "echo 'c' | @user.timeout 2 '${cmd_touch} ; echo NO PRINT THIS'" 3>/dev/null
[ -f "${tmp_file}" ] && @@assert.fail "${cmd_touch} should not have been created!"

# User input uppser 'C'
@log.cmd "echo 'C' | @user.timeout 2 '${cmd_touch} ; echo NO PRINT THIS'" 3>/dev/null
[ -f "${tmp_file}" ] && @@assert.fail "${cmd_touch} should not have been created!"

# User input ESC
@log.cmd "echo -e \"\${BX_KEY_ESC}\" | @user.timeout 2 '${cmd_touch} ; echo NO PRINT THIS'" 3>/dev/null
[ -f "${tmp_file}" ] && @@assert.fail "${cmd_touch} should not have been created!"

# All ok
return 0

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
