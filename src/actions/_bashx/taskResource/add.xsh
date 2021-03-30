local orig="$1"
local dest="$2"

if [ -n "${orig}" ]; then
  orig="${orig}"
  if [ -f "${orig}" ] || [ -d "${orig}" ]; then
    [ -n "${dest}" ] || dest="$(@file.name "${orig}")"
    dest="${BASHX_RESOURCES_PATH}/${dest}"

    if [ -f "${dest}" ] || [ -d "${dest}" ]; then
      @app.error "${dest} already exist!"
    else
      [ -d "${BASHX_RESOURCES_PATH}" ] || mkdir -p "${BASHX_RESOURCES_PATH}"
      cp -vrf "${orig}" "${dest}"
      @log "Resource '${orig}' added!"
      @log "Resource: '${dest}'"
    fi
  else
    @app.error "Cannot add '${orig}': no such file or directory"
  fi
else
  @app.error "Missing values"
fi

@app.exit

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
