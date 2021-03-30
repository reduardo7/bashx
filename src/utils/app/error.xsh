## msg [print_backtrace [code]]
## Show error message at stderr and exit.
##
## Params:
##   msg:             {String} Error message.
##   print_backtrace: {Boolean} Show Backtrace?
##                    Optional. Default: false.
##   code:            {Integer} Exit code.
##                    Otional. Default: 1.

local msg="$1"
local print_backtrace=${2:-false}
local code=${3:-1}

if [ ! -z "${msg}" ]; then
  @log.warn
  @log.alert "${msg}"
  @log.warn
fi

$print_backtrace && @log.warn "Backtrace:\n$(@app.backtrace)"

@app.exit ${code}

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
