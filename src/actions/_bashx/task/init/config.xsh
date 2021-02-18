if [ -f "${BASHX_APP_CONFIG_FILE}" ]; then
  @log.warn "Configuration file '$(@style bold color:blue)${BASHX_APP_CONFIG_FILE}$(@style)' already exists!"
else
  touch "${BASHX_APP_CONFIG_FILE}" || @app.error "Can not create file '$(@style bold color:blue)${BASHX_APP_CONFIG_FILE}$(@style)'"
  @log "Configuration file '$(@style bold color:blue)${BASHX_APP_CONFIG_FILE}$(@style)' $(@style bold color:green)added$(@style)!"
fi

@app.exit
