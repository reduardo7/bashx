@@assert.notEmpty "${BASHX_APP_TMP_PATH}"

[ -d "${BASHX_APP_TMP_PATH}" ] || @@assert.fail "Path not found: ${BASHX_APP_TMP_PATH}"

touch "${BASHX_APP_TMP_PATH}/test" || @app.error
@@assert.equal $? 0

@log "BASHX_APP_TMP_PATH: ${BASHX_APP_TMP_PATH}"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
