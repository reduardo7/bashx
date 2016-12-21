##
## Print basic usage (this).

@print
@print "Usage:"
@print

# Actions
if [ -d "${ACTIONS_PATH}" ]; then
  for f in ${ACTIONS_PATH}/* ; do
    if [ -f "${f}" ]; then
      @usage "${f}"
    fi
  done
fi

# Base Actions
for f in ${BASHX_ACTIONS_PATH}/* ; do
  if [ -f "${f}" ]; then
    @usage "${f}"
  fi
done
