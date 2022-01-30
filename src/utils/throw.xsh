## *
## Throw illegal error and exit.
##
## Params:
##   *: {String} Error message.

BX_APP_EXIT_ILLEGAL_ERROR=true

${BASHX_APP_COLORS_ENABLED} && local err_char='❌❌❌' || local err_char='@@@'

echo >&2
@log.alert "${err_char} Error! ${err_char}"
@app.error "$@" true 1

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
