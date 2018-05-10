##
## Print basic usage (this).

local prefix="${SCRIPT_FILE_NAME} "
local line

@title 'Help & Usage'

# Main
@usage-main "${SCRIPT_FULL_PATH}" "${prefix}"

# Actions
if [ -d "${ACTIONS_PATH}" ]; then
  for f in ${ACTIONS_PATH}/*.sh ; do
    if [ -f "${f}" ]; then
      @usage "${f}" "${prefix}"
    fi
  done
fi

# Base Actions
for f in ${BASHX_ACTIONS_PATH}/*.sh ; do
  if [ -f "${f}" ]; then
    @usage "${f}" "${prefix}"
  fi
done
