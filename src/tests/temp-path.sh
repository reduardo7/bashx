@@assert.notEmpty "${BX_APP_TMP_PATH}"

[ -d "${BX_APP_TMP_PATH}" ] || @@assert.fail "Path not found: ${BX_APP_TMP_PATH}"

touch "${BX_APP_TMP_PATH}/test"
@@assert.equal $? 0

@print "BX_APP_TMP_PATH: ${BX_APP_TMP_PATH}"
