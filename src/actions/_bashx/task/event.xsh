local action="$1"
local name="$2"

if @array.contains "${name}" "${BX_EVENTS_OPTS[@]}"; then
  fwUtils.commonAction "${action}" "${name}" "${BASHX_EVENTS_PATH}" <<EOF
${BASHX_DOC_MARK} Description...

@throw.notImplemented '@TODO'
EOF
fi

@log.warn 'Invalid name!'
