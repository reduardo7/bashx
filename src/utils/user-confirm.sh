## [msg]
## User confirm.
##
## Params:
##   msg: {String} Message.
##        Optional. Default: "Confirm?".
##
## Return: 0 if user confirm, 1 if user not confirm.

local msg="${1:-Confirm?}"

echo -n "$(@style default)${APP_PRINT_PREFIX} $msg (y/n) " >&3

while true ; do
  read -s -n 1 choice >&3
  case "$choice" in
    y|Y ) echo Y >&3 ; return 0 ;;
    n|N ) echo N >&3 ; return 1 ;;
  esac
done
