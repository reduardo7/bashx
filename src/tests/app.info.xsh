result="$(@app.info)"

@@assert.notEmpty "${result}"
@@assert.contains "${result}" "${BASHX_APP_TITLE}"
@@assert.contains "${result}" "v${BASHX_APP_VERSION}"

@@assert.stdOut "@app.info 'output this'"
@@assert.noErrOut "@app.info 'no output this'"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
