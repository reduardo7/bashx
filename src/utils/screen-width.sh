## [default_width]
## Screen width.
##
## Params:
##   default: {Integer} Screen width default if `tput` is not exists.
##            Optional. Default: $APP_WIDTH
##
## Out: {Integer} Screen width.

local default_width=${1:-${APP_WIDTH}}

if command -v tput >/dev/null 2>&1; then
  tput cols
else
  if ! @is-number "${default_width}"; then
    default_width=${APP_WIDTH}
  fi

  echo ${default_width}
fi
