##
## Development Doc.

_doc() {
  export BASHX_APP_COLORS_ENABLED=false
  export BASHX_APP_PRINT_PREFIX='# '
  unset __print_var_prefix__

  @log.title "Development Documentation"

  while IFS= read -r -d '' f; do
    @usage "${f}" '@' '' ''
  done < <(find "${BX_UTILS_PATH}" -name "*.${BX_SCRIPT_EXTENSION}" -print0 | sort -z)
}

_doc 3>&1 2>&1 | less

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
