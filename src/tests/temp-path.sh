@@assertNotEmpty "$APP_TMP_PATH"

[ -d "$APP_TMP_PATH" ] || @@assertFail "Path not found: $APP_TMP_PATH"

touch "$APP_TMP_PATH/test"
@@assertEqual $? 0

@print "APP_TMP_PATH: $APP_TMP_PATH"
