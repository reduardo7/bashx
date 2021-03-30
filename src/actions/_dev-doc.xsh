##
## Development Doc.

_doc() {
  local prefix="$(@style color:red)${BX_SCRIPT_FILE_NAME}"

  @log.title "Development Documentation"

  for f in "${BASHX_UTILS_PATH}"/*.${BX_SCRIPT_EXTENSION} ; do
    if [ -f "${f}" ]; then
      @usage "${f}" '@'
    fi
  done
}

_doc 3>&1 2>&1 | less

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
