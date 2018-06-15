## *
## Throw illegal error and exit.
##
## Params:
##   *: {String} Error message.

BASHX_APP_EXIT_ILLEGAL_ERROR=true

echo >&2
@alert '@@@ Error! @@@'
@error "$@" true 1
