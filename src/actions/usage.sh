## [action]
## Print basic usage (this).
##
## Params:
##   action: Action Name. Display action usage.

@e
@e "Usage:"
@e

# Actions
if [ -d "${ACTIONS_PATH}" ]; then
  for f in ${ACTIONS_PATH}/* ; do
    if [ -f "${f}" ]; then
      @usage "${f}" "$1"
    fi
  done
fi
