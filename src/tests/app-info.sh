result="$(@app-info)"

@@assertNotEmpty "${result}"
@@assertContains "${result}" "${APP_TITLE}"
@@assertContains "${result}" "v${APP_VERSION}"

@@assertStdOut "@app-info 'output this'"
@@assertNoErrOut "@app-info 'no output this'"