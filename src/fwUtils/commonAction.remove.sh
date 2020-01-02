if [ -d "${path}" ]; then
  if [ -f "${script}" ]; then
    rm -f "${script}" || @app.error "Can not remove file '$(@style bold color:blue)${script}$(@style default)'"
    @log "File '$(@style bold color:blue)${script}$(@style default)' $(@style bold color:red)deleted$(@style default)!"
  fi

  # Empty directory?
  if [ -z "$(ls -A "${path}")" ]; then
    rm -rf "${path}" || @app.error "Can not remove directory '$(@style bold color:blue)${path}$(@style default)'"
    @log "Directory '$(@style bold color:blue)${path}$(@style default)' now is empty, $(@style bold color:red)deleted$(@style default)!"
  fi
fi

@app.exit
