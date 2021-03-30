local name="$1"
local path="$2"
local script="${path}/${name}.${BX_SCRIPT_EXTENSION}"

if [[ ! -d "${path}" ]]; then
  mkdir -p "${path}" || @app.error "Can not create directory '$(@style bold color:blue)${path}$(@style)'"
  @log "Directory '$(@style bold color:blue)${path}$(@style)' $(@style bold color:green)created$(@style)!"
fi

if [[ -f "${script}" ]]; then
  @log.warn "Script '$(@style bold color:blue)${script}$(@style)' already exists!"
else
  cat /dev/stdin >"${script}" || @app.error "Can not create file '$(@style bold color:blue)${script}$(@style)'"
  @log "Script '$(@style bold color:blue)${script}$(@style)' $(@style bold color:green)added$(@style)!"
fi

@app.exit

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
