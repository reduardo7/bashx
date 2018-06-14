result="$(@app-info)"

@@assert.notEmpty "${result}"
@@assert.contains "${result}" "${BX_APP_TITLE}"
@@assert.contains "${result}" "v${BX_APP_VERSION}"

@@assert.stdOut "@app-info 'output this'"
@@assert.noErrOut "@app-info 'no output this'"
