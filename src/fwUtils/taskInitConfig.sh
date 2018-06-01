if [ -f "${APP_CONFIG_FILE}" ]; then
  @warn "Configuration file '$(@style bold color:blue)${APP_CONFIG_FILE}$(@style default)' already exists!"
else
  touch "${APP_CONFIG_FILE}" || @error "Can not create file '$(@style bold color:blue)${APP_CONFIG_FILE}$(@style default)'"
  @print "Configuration file '$(@style bold color:blue)${APP_CONFIG_FILE}$(@style default)' $(@style bold color:green)added$(@style default)!"
fi

@end
