## [default_width]
## Screen width.
##
## Params:
##   default: {Integer} Screen width default if `tput` is not exists.
##            Optional. Default: ${BX_BASHX_APP_WIDTH}
##
## Out: {Integer} Screen width.

local default_width=${1:-${BASHX_APP_WIDTH}}

if command -v tput >/dev/null 2>&1; then
  tput cols 2>/dev/null || echo ${default_width}
else
  echo ${default_width}
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
