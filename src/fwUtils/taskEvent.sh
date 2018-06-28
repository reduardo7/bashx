local action="$1"
local name="$2"

if @array-contains "${name}" "${BASHX_EVENTS_OPTS[@]}"; then
  fwUtils.commonAction "${action}" "${name}" "${BX_EVENTS_PATH}" <<EOF
${BASHX_DOC_MARK} Description...

@throw-not-implemented '@TODO'
EOF
fi

@warn 'Invalid name!'
