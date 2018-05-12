@@assert.notEmpty "$APP_TMP_PATH"

[ -d "$APP_TMP_PATH" ] || @@assert.fail "Path not found: $APP_TMP_PATH"

touch "$APP_TMP_PATH/test"
@@assert.equal $? 0

@print "APP_TMP_PATH: $APP_TMP_PATH"
