local action="$1"
local name="$2"

if @array-contains "${name}" "${EVENTS_OPTS[@]}"; then
  fwUtils.commonAction "${action}" "${name}" "${EVENTS_PATH}" <<EOF
${BASHX_DOC_MARK} Description...

@error '@TODO Implement me!'
EOF
fi

@warn 'Invalid name!'
