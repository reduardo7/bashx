##
## Print basic usage (this).

@e
@e "Usage:"
@e

# Base Actions
for f in ${BASHX_ACTIONS_PATH}/* ; do
  if [ -f "${f}" ]; then
    @usage "${f}"
  fi
done

# Actions
if [ -d "${ACTIONS_PATH}" ]; then
  for f in ${ACTIONS_PATH}/* ; do
    if [ -f "${f}" ]; then
      @usage "${f}"
    fi
  done
fi
