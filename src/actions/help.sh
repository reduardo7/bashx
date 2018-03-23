##
## Print basic usage (this).

local prefix="${SCRIPT_FILE_NAME} "

@print
@print "Usage:"
@print

# Main
egrep "^\\s*${ACTION_PREFIX}\.[^()]+\\(\\)\\s*\\{" "${SCRIPT_FULL_PATH}" \
  | egrep -v "^\\s*${ACTION_PREFIX}\._" \
  | while read line
  do
    line="  $(@style color:red)${prefix}$(@style color:green)$(@str-replace "${line}" "^\\s*${ACTION_PREFIX/\@/\\@}\\." '')"
    line="$(@str-replace "${line}" '\(\)\s*\{\s*#*\s*' "$(@style default) ")"
    line="$(@str-replace "${line}" '\s*\\n\s*' "\n${APP_PRINT_PREFIX}     ")"
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
