@@assert.notEmpty "${BX_APP_TMP_PATH}"

[ -d "${BX_APP_TMP_PATH}" ] || @@assert.fail "Path not found: ${BX_APP_TMP_PATH}"

touch "${BX_APP_TMP_PATH}/test" || @app.error
@@assert.equal $? 0

@log "BX_APP_TMP_PATH: ${BX_APP_TMP_PATH}"
