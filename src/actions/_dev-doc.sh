##
## Development Doc.

_doc() {
  local prefix="$(@style color:red)${SCRIPT_FILE_NAME}"

  @title "Development Documentation"
  @title Utils

  for f in $BASHX_UTILS_PATH/*.sh ; do
    if [ -f "${f}" ]; then
      @usage "${f}" '@'
    fi
  done
}

_doc 3>&1 2>&1 | less