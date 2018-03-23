# Run APP.
# Run arguments as commands if any, or show 'help'.
#
# Use: At end of /app file, put next:
#   @init "$@"

# Call @init once
unset -f @init

# info out > std out
exec 3>&1

local p='()'

# Load base utils
for __fn__path__ in ${BASHX_UTILS_PATH}/*.sh ; do
  if [ -f "${__fn__path__}" ]; then
    # Create base util function
    eval "@$(@file-name "${__fn__path__}" true)${p} { . "${__fn__path__}"; }"
  fi
done

# Load base actions
for __fn__path__ in ${BASHX_ACTIONS_PATH}/*.sh ; do
  if [ -f "${__fn__path__}" ]; then
    # Create base action function
    eval "${_ACTION_PREFIX}.$(@file-name "${__fn__path__}" true)${p} { . "${__fn__path__}"; }"
  fi
done

# Load custom utils
if [ -d "${UTILS_PATH}" ]; then
  for __fn__path__ in ${UTILS_PATH}/*.sh ; do
    if [ -f "${__fn__path__}" ]; then
      # Create util function
      eval "$(@file-name "${__fn__path__}" true)${p} { . "${__fn__path__}"; }"
    fi
  done
fi

# Load custom actions
if [ -d "${ACTIONS_PATH}" ]; then
  for __fn__path__ in ${ACTIONS_PATH}/*.sh ; do
    if [ -f "${__fn__path__}" ]; then
      # Create action function
      eval "${_ACTION_PREFIX}.$(@file-name "${__fn__path__}" true)${p} { . "${__fn__path__}"; }"
    fi
  done
fi

# Start
local r=1
echo >&3

@title "$(@app-info)"

# On end Script
trap @end EXIT

# On CTRL + C
trap @end INT

if [ $# -gt 0 ]; then
  # If function exists
  if @function-exists "${_ACTION_PREFIX}.$1" ; then
    # Exec
    if [ "$1" == 'help' ]; then
      ACTION='help'
    else
      ACTION="$1"
    fi
    ${_ACTION_PREFIX}."$@"
    r=$?
  else
      @error "Parameter '$(@style color:green)${1}$(@style color:red)' not found. Call 'help' to see help." false
  fi
fi

if [ ${#1} == 0 ]; then
  if [ -z "${helpDEFAULT_ACTION}" ]; then
    # Show help
    ACTION='help'
    r=1
  else
    # Call default action
    ACTION="$DEFAULT_ACTION"
  fi

  ${_ACTION_PREFIX}.${ACTION}
fi

# Return result code
@end $r
