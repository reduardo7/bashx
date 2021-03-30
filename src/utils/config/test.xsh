## config_file [fail_on_error]
## Validate configuration file.
##
## Params:
##   config_file:   {String} Config file path.
##   fail_on_error: {Boolean} Fail on error?
##                  Default: true
##
## Return: 0 on valid, 1 on error.

local config_file="${1}"
local fail_on_error=${2:-true}

@log "Validating config file '${config_file}'..."

# Test config
( set -e +x
  . "${config_file}"
) && return 0 || {
  # Show config errors
  ( set -ex
    . "${config_file}"
  ) || true

  if ${fail_on_error}; then
    @app.error "Invalid config file! '${config_file}'"
  else
    return 1
  fi
}

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
