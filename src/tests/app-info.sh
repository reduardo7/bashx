result="$(@app-info)"

@@assert.notEmpty "${result}"
@@assert.contains "${result}" "${APP_TITLE}"
@@assert.contains "${result}" "v${APP_VERSION}"

@@assert.stdOut "@app-info 'output this'"
@@assert.noErrOut "@app-info 'no output this'"
