##
## Print basic usage (this).

local prefix="$(@script-file-name) "

@print
@print "Usage:"
@print

# Main
egrep "^\\s*${_ACTION_PREFIX}\.[^()]+\\(\\)\\s*\\{" "${CURRENT_SOURCE}" \
  | egrep -v "^\\s*${_ACTION_PREFIX}\._" \
  | while read line
  do
    line="  $(@style color:red)${prefix}$(@style color:green)$(@str-replace "${line}" "^\\s*${_ACTION_PREFIX/\@/\\@}\\." '')"
    line="$(@str-replace "${line}" '\(\)\s*\{\s*#*\s*' "$(@style default) ")"
    line="$(@str-replace "${line}" '\s*\\n\s*' "\n${ECHO_CHAR}     ")"
    @print "$(@str-replace "${line}" '\s*\\t\s*' '    ')"
    @print # Space
  done

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
