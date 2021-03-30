if [ -d "${path}" ]; then
  if [ -f "${script}" ]; then
    rm -f "${script}" || @app.error "Can not remove file '$(@style bold color:blue)${script}$(@style)'"
    @log "File '$(@style bold color:blue)${script}$(@style)' $(@style bold color:red)deleted$(@style)!"
  fi

  # Empty directory?
  if [ -z "$(ls -A "${path}")" ]; then
    rm -rf "${path}" || @app.error "Can not remove directory '$(@style bold color:blue)${path}$(@style)'"
    @log "Directory '$(@style bold color:blue)${path}$(@style)' now is empty, $(@style bold color:red)deleted$(@style)!"
  fi
fi

@app.exit

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
