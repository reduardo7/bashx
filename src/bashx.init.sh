# Run APP.
# Run arguments as commands if any, or show "usage".
#
# See "usage" to see how to use.
#
# Use: At end of file, put next:
#   @init "$@"
local p='()'

# Load base utils
for __fn__path__ in ${BASHX_UTILS_PATH}/* ; do
  if [ -f "${__fn__path__}" ]; then
    # Create base util function
    eval "$(@file-name "${__fn__path__}" true)${p} { . "${__fn__path__}"; }"
  fi
done

# Load base actions
for __fn__path__ in ${BASHX_ACTIONS_PATH}/* ; do
  if [ -f "${__fn__path__}" ]; then
    # Create base action function
    eval "${_ACTION_PREFIX}$(@file-name "${__fn__path__}" true)${p} { . "${__fn__path__}"; }"
  fi
done

# Load custom utils
if [ -d "${UTILS_PATH}" ]; then
  for __fn__path__ in ${UTILS_PATH}/* ; do
    if [ -f "${__fn__path__}" ]; then
      # Create util function
      eval "$(@file-name "${__fn__path__}" true)${p} { . "${__fn__path__}"; }"
    fi
  done
fi

# Load custom actions
if [ -d "${ACTIONS_PATH}" ]; then
  for __fn__path__ in ${ACTIONS_PATH}/* ; do
    if [ -f "${__fn__path__}" ]; then
      # Create action function
      eval "${_ACTION_PREFIX}$(@file-name "${__fn__path__}" true)${p} { . "${__fn__path__}"; }"
    fi
  done
fi

# Start
local r=1
echo >&2

@title "$(@app-info)"

# On end Script
trap @end EXIT

# On CTRL + C
trap @end INT

if [ $# -gt 0 ]; then
  # If function exists
  if @function-exists "${_ACTION_PREFIX}$1" ; then
    # Exec
    if [ "$1" == "help" ]; then
      ACTION="usage"
    else
      ACTION="$1"
    fi
    ${_ACTION_PREFIX}"$@"
    r=$?
  else
      @error "Parameter '`@style color:green`${1}`@style color:red`' not found. Call 'usage' to see help."
  fi
fi

if [ ${#1} == 0 ]; then
  if [ -z "${DEFAULT_ACTION}" ]; then
    # Show usage
    ACTION="usage"
    ${_ACTION_PREFIX}usage
    r=1
  else
    # Call default action
    ACTION="$DEFAULT_ACTION"
    ${_ACTION_PREFIX}${DEFAULT_ACTION}
  fi
fi

# Return result code
@end $r
