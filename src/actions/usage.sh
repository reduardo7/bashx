##
## Print basic usage (this).

@print
@print "Usage:"
@print

# Main
egrep "^\\s*${_ACTION_PREFIX}\.[^()]+\\(\\)\\s*\\{" "${CURRENT_SOURCE}" \
  | egrep -v "^\\s*${_ACTION_PREFIX}\._" \
  | while read line ; do
    line="$(@style color:red)${CURRENT_SCRIPT} $(@style color:green)$(@str-replace "${line}" "^\\s*${_ACTION_PREFIX/\@/\\@}\\." '')"
    line="$(@str-replace "${line}" '\(\)\s*\{\s*#*\s*' "$(@style default) ")"
    line="$(@str-replace "${line}" '\s*\\n\s*' "\n${ECHO_CHAR}     ")"
    line="$(@str-replace "${line}" '\s*\\t\s*' '    ')"
    @print "  ${line}"
    @print # Space
  done

_usage() {
  local src_name="$(@script-file-name)"
  local src="$1"
  local cmd="$(@file-name "${src}" true)"

  [[ "${cmd}" == _* ]] && return 0 # Brak

  local lp='    '
  local lpl=${#lp}
  local first_line=true
  local sd="$(@style default)"
  local info

  if [ -z "${src}" ] || [ ! -f "${src}" ]; then
    @error "Invalid file '${src}'" true 200
  fi

  # Get comments from file
  egrep '^##' "${src}" | egrep -v '^###' | while read line
    do
      if ${first_line}; then
        first_line=false
        @print "  $(@style color:red)${src_name}$(@style color:green) ${cmd}${sd} $(@str-replace "${line}" '^##\s*' '')"
      else
        @print "$(@str-replace "${line}" '^##\s' "${sd}${lp}")"
      fi
    done

  @print
}

# Actions
if [ -d "${ACTIONS_PATH}" ]; then
  for f in ${ACTIONS_PATH}/*.sh ; do
    if [ -f "${f}" ]; then
      _usage "${f}"
    fi
  done
fi

# Base Actions
for f in ${BASHX_ACTIONS_PATH}/*.sh ; do
  if [ -f "${f}" ]; then
    _usage "${f}"
  fi
done
