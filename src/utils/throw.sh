## *
## Throw illegal error and exit.
##
## Params:
##   *: {String} Error message.

BASHX_APP_EXIT_ILLEGAL_ERROR=true

echo >&2
@log.alert '@@@ Error! @@@'
@app.error "$@" true 1
