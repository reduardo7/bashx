## [msg]
## User confirm.
##
## Params:
##   msg: {String} Message.
##        Optional. Default: "Confirm?".
##
## Return:
##   0 if user confirm.
##   1 if user not confirm.
##   254 if no TTY.

local msg="${1:-Confirm?}"
local choice
local result=3

echo -n "$(@style)${BASHX_APP_PRINT_PREFIX} ${msg} (y/n) " >&3

if ${BX_TTY}; then
  while [[ ${result} -gt 1 ]] ; do
    read -s -n 1 choice >&3 || true

    case "${choice}" in
      y|Y ) result=0 ;;
      n|N ) result=1 ;;
    esac
  done
else
  @log.warn 'Not at TTY! confirm cancelled...'
  return 254
fi

if [[ ${result} -eq 0 ]] ; then
  echo Y >&3
else
  echo N >&3
fi

read -s -t 1 choice || true
return ${result}

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
